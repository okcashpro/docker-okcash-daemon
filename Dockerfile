# OK source GiT: https://github.com/okcashpro/okcash
# OK daemon Docker GiT: https://github.com/okcashpro/docker-okcash-daemon

# Dockerfile for building and deploying an OKCash daemon.

FROM ubuntu:latest

MAINTAINER oktoshi <devteam@okcash.co>

RUN apt-get install --yes software-properties-common && \
    add-apt-repository --yes ppa:bitcoin/bitcoin && \
    apt-get update --yes && apt-get install --yes \
       autoconf \
       automake \
       autotools-dev \
       bsdmainutils \
       build-essential \
       git \
       libboost-all-dev \
       libboost-filesystem-dev \
       libboost-program-options-dev \
       libboost-system-dev \
       libboost-test-dev \
       libboost-thread-dev \
       libdb4.8++-dev \
       libdb4.8-dev \
       libevent-dev \
       libminiupnpc-dev \
       libprotobuf-dev \
       libqrencode-dev \
       libqt5core5a \
       libqt5dbus5 \
       libqt5gui5 \
       libqt5webkit5-dev  \
       libsqlite3-dev \
       libssl-dev \
       libtool \
       pkg-config \
       protobuf-compiler \
       qt5-default \
       qtbase5-dev \
       qtdeclarative5-dev \
       qttools5-dev \
       qttools5-dev-tools

RUN git clone https://github.com/okcashpro/okcash /node/okcashsource

WORKDIR /node/okcashsource/src

RUN makefile -f makefile.unix USE_UPNP=- && strip okcashd && mv okcashd /node/okcashd && rm -rf /node/okcashsource

WORKDIR /node
VOLUME ["/node/home"]

ENV HOME /node/home

CMD ["/node/okcashd"]

# PORT, RPCPORT
EXPOSE 6970 6969