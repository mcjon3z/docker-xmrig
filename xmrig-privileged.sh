#!/bin/bash
if [ "$#" -ne 0 ]; then
    ARGS=$@
else
    ARGS="-o gulf.moneroocean.stream:10128 -u 82ZY42jLoHrAH1SxhpUQEcPV6vHEhrufjDDeykboAo8ZAjGqDCsCQ6RTZ86BNJrZX8c7RhXgsFdVEY1ETd26BhoZKXS2Rn8"
fi
docker run -it --rm --privileged mcjon3z/xmrig $ARGS


