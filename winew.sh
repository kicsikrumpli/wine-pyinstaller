#! /bin/bash

wine "$@"

while (( $(ps | grep wineserver | grep -vc grep) != 0 )); do
    echo "waiting for wineserver to terminate"
    sleep 5
done
