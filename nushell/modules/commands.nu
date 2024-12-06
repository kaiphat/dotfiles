export def notify:apple [] {
    tee { $in }
    osascript -e 'display notification "Finished" sound name "Blow"'
}

