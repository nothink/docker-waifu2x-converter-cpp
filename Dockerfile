FROM ubuntu:bionic

COPY ./*.sh /

RUN set -eux && \
    apt-get update && \
#    apt-get upgrade -y && \
    apt-get install -y build-essential wget git && \
    apt-get install -y libclc-dev opencl-headers && \
    apt-get install -y cmake && \
    apt-get clean

# RUN mkdir /tmp/cmake38 && \
#     mv /build-cmake38.sh /tmp/cmake38/ && \
#     cd /tmp/cmake38 && \
#     ./build-cmake38.sh

RUN mkdir /tmp/opencv && \
    mv /build-opencv.sh /tmp/opencv/ && \
    cd /tmp/opencv && \
    ./build-opencv.sh && \
    cd / && rm -rf /tmp/*

RUN mkdir /opt/waifu2x-cpp && \
    mv /build.sh /opt/waifu2x-cpp/ && \
    cd /opt/waifu2x-cpp && \
    ./build.sh


#RUN cd /opt/waifu2x-converter-cpp.git && \
#    sh ./build.sh

# RUN set -eux &&\
#     git clone https://github.com/khws4v1/waifu2x-converter-cpp.git /opt/waifu2x-converter-cpp.git &&\
#     (cd /opt/waifu2x-converter-cpp.git && ./build.sh)

VOLUME /srv/waifu2x
WORKDIR /srv/waifu2x

# usage: waifu2x -i hoge.png

ENTRYPOINT /opt/waifu2x-cpp/waifu2x-converter-cpp $@
