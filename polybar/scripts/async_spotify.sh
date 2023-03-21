import asyncio
import re
import signal
from datetime import datetime, timedelta
from typing import Literal, List

# Note: index i+1 corresponds to font-i in polybar
TEXT_FONT_INDEX = 2  # monospace!
ICON_FONT_INDEX = 3  # Use Font Awesome! Using Nerd Fonts can cause issues

TEXT_UPDATE_TIMEOUT = 0.3  # sec
STATE_UPDATE_BLOCKING_TIME = 0.2  # sec
PERIODIC_STATE_UPDATE_TIMEOUT = 5  # sec

NUMBER_CHARACTERS = 25

PLAYER_SYMBOL = {"spotify": "", "firefox": "", "chromium": "", "kdeconnect": "", "default": ""}
CONTROL_SYMBOLS = ["", "", "", ""]
PLAYER_STATES = ["stopped", "playing", "paused"]
METADATA_KEYS = ["xesam:artist", "xesam:album", "xesam:title"]
METADATA_SEP = " - "

player_metadata: List[str] = []
player_state: Literal["stopped", "playing", "paused"] = "stopped"
current_metadata_text = ""
current_player = ""
last_metadata_state_update = datetime.min


def get_control_str() -> str:
    prev_button = r"%{A:playerctl previous:}" + CONTROL_SYMBOLS[0] + r"%{A}"
    play_button = r"%{A:playerctl play-pause:}" + CONTROL_SYMBOLS[1] + r"%{A}"
    pause_button = r"%{A:playerctl play-pause:}" + CONTROL_SYMBOLS[2] + r"%{A}"
    next_button = r"%{A:playerctl next:}" + CONTROL_SYMBOLS[3] + r"%{A}"

    return (
        prev_button
        + " "
        + (play_button if player_state == "playing" else pause_button)
        + " "
        + next_button
    )


def set_font(index: int, text: str):
    return r"%{T" + str(index) + "}" + text + r"%{T-}"


async def update_metadata():
    global current_player
    global player_metadata
    global current_metadata_text
    global player_state
    global last_metadata_state_update

    if datetime.now() - last_metadata_state_update < timedelta(
        seconds=STATE_UPDATE_BLOCKING_TIME
    ):
        return
    last_metadata_state_update = datetime.now()

    p = await asyncio.create_subprocess_shell(
        "playerctl metadata",
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.DEVNULL,
    )
    stdout, _ = await p.communicate()

    metadata = stdout.decode().strip()

    new_player = ""
    new_player_metadata = []

    if metadata:
        for key in METADATA_KEYS:
            query = re.search(r"^(\S*)\s+" + key + r" *([^\n]+)?$", metadata, re.M)
            if not query:
                continue
            new_player = query.group(1) or ""
            if query.group(2) is not None:
                new_player_metadata += [query.group(2)]

    if new_player_metadata != player_metadata or current_player != new_player:
        current_player = new_player
        player_metadata = new_player_metadata

        if player_metadata:
            current_metadata_text = METADATA_SEP.join(x for x in player_metadata if len(x))
        else:
            current_metadata_text = "No metadata available"

        if len(current_metadata_text) > NUMBER_CHARACTERS:
            current_metadata_text += METADATA_SEP
        else:
            fill_chars = NUMBER_CHARACTERS - len(current_metadata_text)
            current_metadata_text = (
                " " * (fill_chars // 2)
                + current_metadata_text
                + " " * (fill_chars - fill_chars // 2)
            )

        await print_text()


async def update_playing_state():
    global player_state

    p = await asyncio.create_subprocess_shell(
        "playerctl status",
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.DEVNULL,
    )
    stdout, _ = await p.communicate()

    new_playing_state = stdout.decode().strip().lower()
    if new_playing_state not in PLAYER_STATES:
        new_playing_state = "stopped"

    if new_playing_state != player_state:
        player_state = new_playing_state
        await print_text()


async def print_text():
    global current_metadata_text, player_state

    if player_state == "stopped":
        print("", flush=True)
        return

    player_symbol = set_font(ICON_FONT_INDEX, PLAYER_SYMBOL.get(current_player, PLAYER_SYMBOL["default"]))
    metadata_text = set_font(TEXT_FONT_INDEX, current_metadata_text[:NUMBER_CHARACTERS])
    control_str = set_font(ICON_FONT_INDEX, get_control_str())

    output = f"{player_symbol}  {metadata_text}  {control_str}"

    print(output, flush=True)


async def start_deamon():
    p = await asyncio.create_subprocess_shell(
        "playerctld daemon",
        stdout=asyncio.subprocess.DEVNULL,
        stderr=asyncio.subprocess.DEVNULL,
    )
    await p.communicate()


async def run_update_text():
    global current_metadata_text

    while True:
        await print_text()
        if len(current_metadata_text) > NUMBER_CHARACTERS:
            current_metadata_text = current_metadata_text[1:] + current_metadata_text[0]
        await asyncio.sleep(TEXT_UPDATE_TIMEOUT)


async def run_playerctl_status_update():
    while True:
        p = await asyncio.create_subprocess_shell(
            "playerctl status --follow", stdout=asyncio.subprocess.PIPE
        )
        while True:
            bytes = await p.stdout.readline()
            if not bytes:
                break
            line = bytes.decode().strip()

            # Fix flashing
            if line == "Stopped":
                loop = asyncio.get_running_loop()
                loop.call_later(1, lambda: loop.create_task(update_playing_state()))
            else:
                await update_playing_state()


async def run_playerctl_metadata_update():
    while True:
        p = await asyncio.create_subprocess_shell(
            "playerctl metadata --follow", stdout=asyncio.subprocess.PIPE
        )
        while True:
            bytes = await p.stdout.readline()
            if not bytes:
                break
            await update_metadata()


async def run_periodic_metadata_and_state_update():
    while True:
        await update_playing_state()
        await update_metadata()
        await asyncio.sleep(PERIODIC_STATE_UPDATE_TIMEOUT)


async def shift_current_player():
    p = await asyncio.create_subprocess_shell("playerctld shift")
    await p.wait()
    await update_playing_state()
    await update_metadata()


async def main():
    await start_deamon()

    asyncio.get_event_loop().add_signal_handler(signal.SIGUSR1, lambda: asyncio.ensure_future(shift_current_player()))

    await update_metadata()
    await asyncio.gather(
        run_update_text(),
        run_playerctl_status_update(),
        run_playerctl_metadata_update(),
        run_periodic_metadata_and_state_update(),
    )


if __name__ == "__main__":
    asyncio.run(main())
