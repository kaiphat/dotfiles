INDEX=$(xinput --list | awk '/Razer Razer DeathAdder Essential[^a-zA-Z]+id.*slave.*pointer/' | awk -F "[^0-9]*" '{print $2}')
PROP_INDEX=$(xinput --list-props $INDEX | awk '/Coordinate Transformation Matrix/' | awk -F "[^0-9]*" '{print $2}')
xinput --set-prop $INDEX $PROP_INDEX 1 0 0 0 1 0 0 0 1 &

