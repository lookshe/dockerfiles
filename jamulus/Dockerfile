ARG JAMULUS_VERSION=r3_9_0

FROM debian:buster-backports AS build-stage

ARG JAMULUS_VERSION

RUN apt-get update \
  && apt-get install -y \
      build-essential \
      qt5-qmake \
      qt5-default \
      libjack-jackd2-dev \
      qttools5-dev-tools \
      wget
RUN wget https://github.com/jamulussoftware/jamulus/archive/$JAMULUS_VERSION.tar.gz
RUN tar xzf $JAMULUS_VERSION.tar.gz
RUN cd jamulus-$JAMULUS_VERSION \
  && qmake "CONFIG+=serveronly headless noupcasename" Jamulus.pro \
  && make

FROM scratch

ARG JAMULUS_VERSION

COPY --from=build-stage /jamulus-$JAMULUS_VERSION/jamulus .

