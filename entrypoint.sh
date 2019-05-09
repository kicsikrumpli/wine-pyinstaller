#! /bin/bash

echo "entrypoint.sh $@"

cd /src/
/root/.wine/drive_c/winew.sh pip3 install -r /src/requirements.txt
/root/.wine/drive_c/winew.sh pyinstaller $@
