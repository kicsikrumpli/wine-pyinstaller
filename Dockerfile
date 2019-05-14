# build wine
FROM i386/ubuntu as winebuild
LABEL maintainer="kicsikrumpli@gmail.com"

# build:
# external X server at build time: --build-arg DISPLAY=host.docker.internal:0
# NB! do on host: xhost + 127.0.0.1

# enable source code repos and update: 
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i '/deb-src/s/^# //' /etc/apt/sources.list 
RUN apt-get update && apt-get install -y flex \
    bison \
    gcc \
    build-essential
RUN apt-get build-dep -y wine

# copy, unpack, build wine source
ADD wine-4.7.tar.xz /
WORKDIR /wine-4.7
RUN ./configure && make && make install

RUN apt-get update && apt-get install -y xdotool xvfb

# default for X Virtual Frame Buffer
ARG DISPLAY=:1
ENV DISPLAY=${DISPLAY}
RUN echo "DISPLAY: ${DISPLAY}"

# winecfg
WORKDIR /root/.wine/drive_c
COPY python-3.7.3.exe .

COPY config.sh .
RUN chmod +x config.sh

COPY winew.sh .
RUN chmod +x winew.sh

RUN ./config.sh

# entrypoint
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]