FROM alpine:3.8

COPY ./*.sh /

# install pkgs
RUN apk add --update --no-cache musl libstdc++ && \
    apk add --no-cache --virtual .builddeps \
        build-base gcc make wget git cmake linux-headers opencl-headers && \
# build opencv
    mkdir /tmp/opencv && \
    mv /build-opencv.sh /tmp/opencv/ && \
    cd /tmp/opencv && \
    ./build-opencv.sh && \
    cd / && rm -rf /tmp/* && \
    ln -sf /usr/lib64/*.3.4 /usr/lib/ && \
# build waifu2x-cpp
    mkdir /opt && \
    mv /build.sh /opt/ && \
    cd /opt && \
    ./build.sh && \
# remove pkgs
    apk del --purge .builddeps

WORKDIR /opt/waifu2x-cpp

# usage: waifu2x -i hoge.png -o moge.png
ENTRYPOINT ["/opt/waifu2x-cpp/waifu2x-converter-cpp"]
CMD ["--help"]
