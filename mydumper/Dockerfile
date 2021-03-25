ARG MYDUMPER_VERSION=0.10.3

FROM debian/eol:wheezy AS build-stage

ARG MYDUMPER_VERSION

RUN apt-get update \
  && apt-get install -y \
      build-essential \
      cmake \
      libglib2.0-dev \
      libmysqlclient15-dev \
      zlib1g-dev \
      libpcre3-dev \
      wget
RUN wget --no-check-certificate https://github.com/maxbube/mydumper/archive/refs/tags/v$MYDUMPER_VERSION.tar.gz
RUN tar xzf v$MYDUMPER_VERSION.tar.gz
RUN cd mydumper-$MYDUMPER_VERSION \
  && sed -ie "s/^set(VERSION .*)$/set(VERSION $MYDUMPER_VERSION)/" CMakeLists.txt \
  && cmake -DWITH_SSL=OFF . \
  && make \
  && cd package \
  && sed -ie "s/^SOURCE=\/opt\/src\/mydumper$/SOURCE=\/mydumper-$MYDUMPER_VERSION/" build.sh \
  && sed -E -ie '/^build_deb \"wheezy\"/! s/^build_(deb|rpm) \".*$//' build.sh \
  && sed -E -ie 's/^build_deb \"wheezy\" \"wheezy\"$/build_deb \"\" \"wheezy\"/' build.sh \
  && ./build.sh $MYDUMPER_VERSION 1

FROM scratch

ARG MYDUMPER_VERSION

COPY --from=build-stage /opt/PKGS/mydumper_$MYDUMPER_VERSION-1.wheezy_amd64.deb .

