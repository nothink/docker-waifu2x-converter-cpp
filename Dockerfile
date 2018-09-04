FROM alpine:3.8

COPY ./*.sh /

RUN apk --update --no-cache add \
        build-base gcc make wget git cmake linux-headers opencl-headers

RUN mkdir /tmp/opencv && \
    mv /build-opencv.sh /tmp/opencv/ && \
    cd /tmp/opencv && \
    ./build-opencv.sh && \
    cd / && rm -rf /tmp/*

RUN ln -sf /usr/lib64/*.3.4 /usr/lib/

RUN mkdir /opt && \
    mv /build.sh /opt/ && \
    cd /opt && \
    ./build.sh

VOLUME /srv/waifu2x
WORKDIR /opt/waifu2x-cpp

# usage: waifu2x -i hoge.png -o moge.png
ENTRYPOINT /opt/waifu2x-cpp/waifu2x-converter-cpp $@
