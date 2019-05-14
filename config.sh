#! /bin/bash
  
autorespond() {
    if [[ -z $WINEDLLOVERRIDES ]]; then
        echo ".."   
        waitAndEnter "Wine Mono Installer"
        echo "..."
        waitAndEnter "Wine Gecko Installer"
    else
        echo "Mono and Gecko install skipped"
    fi;

    echo "...."
    waitAndEnter "Wine configuration"
    echo "....."
}

waitAndEnter() {
    title="$1"
    local window
    while [[ -z "$window" ]]; do
        sleep 10
        echo "waiting for $title..."
        set +e
        window=`xdotool search --name "$title"`
        set -e
    done

    echo "found: $window"

    xdotool windowfocus --sync $window
    xdotool key Return
}

startVirtualFrameBuffer() {
    # uncomment to force Xvfb
    # export DISPLAY=:1
    if [[ $DISPLAY == ":1" ]]; then
        echo "starting virtual frame buffer as display 1"
        Xvfb :1 &
    else
        echo "$DISPLAY != 1, assuming external X running"
    fi
}

# comment to enable mono and gecko install popup
export WINEDLLOVERRIDES="mscoree,mshtml="

startVirtualFrameBuffer
autorespond &
winecfg

while (( $(ps | grep wineserver | grep -vc grep) != 0 )); do
    echo "waiting for wineserver to terminate..."
    sleep 5
done

echo "Installing Python..."
./winew.sh python-3.7.3.exe /quiet InstallAllUsers=1 PrependPath=1

echo "Installing Pyinstaller..."
./winew.sh pip3 install pyinstaller