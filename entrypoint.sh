#! /bin/bash

echo "entrypoint.sh $@"

if [[ $1 == "--bash" ]]; then
    /bin/bash "${@:2}"
elif [[ -d /src && -f /src/requirements.txt ]]; then
    cd /src/
    /root/.wine/drive_c/winew.sh pip3 install -r /src/requirements.txt
    /root/.wine/drive_c/winew.sh pyinstaller $@
else
    echo "         _                        _         _        _ _          "
    echo " __ __ _(_)_ _  ___ ___ _ __ _  _(_)_ _  __| |_ __ _| | |___ _ _  "
    echo " \ V  V / | ' \/ -_)___| '_ \ || | | ' \(_-<  _/ _' | | / -_) '_| "
    echo "  \_/\_/|_|_||_\___|   | .__/\_, |_|_||_/__/\__\__,_|_|_\___|_|   "
    echo "                       |_|   |__/                                 "
    echo "Usage:"
    echo "A,"
    echo "To invoke pyinstaller, bind mount script directory as /src and pass pyinstaller parameters"
    echo "docker run -it -v $(pwd):/src kicsikrumpli/wine-pyinstaller --onefile --clean myscript.py "
    echo "---"
    echo "B,"
    echo "To run bash pass --bash, and optionally bash parameters"
    echo "docker run -it kicsikrumpli/wine-pyinstaller --bash"
fi



