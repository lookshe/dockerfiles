ARG JAMULUS_VERSION=r3_6_1

FROM debian:buster-backports AS build-stage

ARG JAMULUS_VERSION

RUN apt-get update \
  && apt-get install -y \
      build-essential \
      qt5-qmake \
      qtdeclarative5-dev \
      qt5-default \
      qttools5-dev-tools \
      wget
RUN wget https://github.com/corrados/jamulus/archive/$JAMULUS_VERSION.tar.gz
RUN tar xzf $JAMULUS_VERSION.tar.gz
RUN cd jamulus-$JAMULUS_VERSION \
  && qmake "CONFIG+=nosound headless noupcasename" Jamulus.pro \
  && make

FROM scratch

ARG JAMULUS_VERSION

COPY --from=build-stage /jamulus-$JAMULUS_VERSION/jamulus .

