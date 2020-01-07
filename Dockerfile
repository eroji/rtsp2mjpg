FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean
COPY stream.sh /usr/bin/stream.sh
RUN chmod +x /usr/bin/stream.sh
COPY ffserver.conf /etc/ffserver.conf
ENV RTSP_URL rtsp://freja.hiof.no:1935/rtplive/definst/hessdalen03.stream
ENTRYPOINT stream.sh
