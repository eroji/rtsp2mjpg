#!/bin/bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

/usr/bin/ffserver -hide_banner -loglevel fatal &
/usr/bin/ffmpeg -hide_banner -loglevel fatal -rtsp_transport tcp -i ${RTSP_URL} http://127.0.0.1:8090/feed.ffm
