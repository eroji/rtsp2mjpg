#!/bin/bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

/usr/bin/ffserver -hide_banner -loglevel ${FFSERVER_LOG_LEVEL} &
/usr/bin/ffmpeg -hide_banner -loglevel ${FFMPEG_LOG_LEVEL} -rtsp_transport tcp ${FFMPEG_INPUT_OPTS} -i ${RTSP_URL} ${FFMPEG_OUTPUT_OPTS} http://127.0.0.1:8090/feed.ffm
