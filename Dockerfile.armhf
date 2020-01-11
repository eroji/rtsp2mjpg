FROM balenalib/raspberry-pi-debian:stretch as builder
RUN apt-get update -qy && apt-get -qy install \
    build-essential git nasm libomxil-bellagio-dev pkg-config wget
WORKDIR /root
RUN wget https://github.com/FFmpeg/FFmpeg/archive/n3.4.7.tar.gz && \
    tar zxf n3.4.7.tar.gz
WORKDIR /root/FFmpeg-n3.4.7
RUN ./configure --arch=armel --target-os=linux --enable-gpl --enable-omx --enable-omx-rpi --enable-nonfree
RUN make -j$(nproc)
RUN make install

FROM balenalib/raspberry-pi-debian:stretch
RUN apt-get update && apt-get install -qy libraspberrypi-bin libomxil-bellagio0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /root
COPY --from=builder /usr/local/bin/ /usr/local/bin
COPY --from=builder /usr/local/lib/ /usr/local/lib
COPY --from=builder /usr/local/share/ffmpeg/ /usr/local/share/ffmpeg
COPY --from=builder /usr/local/share/man/ /usr/local/share/man
COPY stream.sh /usr/bin/stream.sh
RUN chmod +x /usr/bin/stream.sh
COPY ffserver.conf-armhf /etc/ffserver.conf
ENV RTSP_URL rtsp://freja.hiof.no:1935/rtplive/definst/hessdalen03.stream
ENV FFMPEG_INPUT_OPTS  ""
ENV FFMPEG_OUTPUT_OPTS  ""
ENV FFSERVER_LOG_LEVEL "error"
ENV FFMPEG_LOG_LEVEL  "warning"
ENTRYPOINT stream.sh
