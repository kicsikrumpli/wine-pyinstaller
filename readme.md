# Wine Pyinstaller

Compile Python 3.x scripts with Pyinstaller into 32 bit Windows executables on Ubuntu with Wine.

## Build Image

By default X window display is set to X virtual frame buffer as `DISPLAY=:1`. Winecfg popups are not displayed, button presses are automated.

To observe build time windows on external X server:

- `--build-arg DISPLAY=host.docker.internal:0`
- `xhost + 127.0.0.1` on host to enable connection to X11 from docker image
- enable XTEST for XQuartz on mac for automated keypresses to work

### Example Build

````bash
docker build -t kicsikrumpli/wine-pyinstaller:latest .
````

## Build 32 bit windows python apps

- bind mount current directory with script to `/src/`
- assumes presence of `requirements.txt`
- docker run parameters are passed to pyinstaller

### Example Run

````bash
docker run -it -v $(pwd):/src kicsikrumpli/wine-pyinstaller --clean --onefile my_python_script.py
````
