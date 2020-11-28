ARG JAMULUS_VERSION=r3_6_1

FROM debian/eol:wheezy AS build-stage

ARG JAMULUS_VERSION

RUN echo "deb http://archive.debian.org/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.debian.org/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update \
  && apt-get install -y \
      build-essential \
      qt5-qmake \
      qtdeclarative5-dev \
      qt5-default \
      qttools5-dev-tools \
      wget
RUN wget --no-check-certificate https://github.com/corrados/jamulus/archive/$JAMULUS_VERSION.tar.gz
RUN tar xzf $JAMULUS_VERSION.tar.gz
# fix "error: 'runtime_error' is not a member of 'std'"
RUN sed -i '37i#include <stdexcept>' jamulus-$JAMULUS_VERSION/src/recorder/jamrecorder.h
RUN cd jamulus-$JAMULUS_VERSION \
  && qmake "CONFIG+=nosound headless noupcasename" Jamulus.pro \
  && make

FROM scratch

ARG JAMULUS_VERSION

COPY --from=build-stage /jamulus-$JAMULUS_VERSION/jamulus .

