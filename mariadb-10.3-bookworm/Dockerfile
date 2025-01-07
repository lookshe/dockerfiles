FROM docker.io/debian:bookworm as build-stage

RUN sed -i 's/Types: deb$/Types: deb deb-src/g' /etc/apt/sources.list.d/debian.sources
RUN apt-get update \
  && apt-get build-dep -y mariadb-server
RUN apt-get update \
  && apt-get install -y \
      software-properties-common \
      devscripts \
      chrpath \
      dh-apparmor \
      libaio-dev \
      libpcre3-dev \
      wget
RUN wget http://ftp.de.debian.org/debian/pool/main/r/readline5/libreadline5_5.2+dfsg-3+b13_amd64.deb
RUN dpkg -i libreadline5_5.2+dfsg-3+b13_amd64.deb
RUN wget http://ftp.de.debian.org/debian/pool/main/r/readline5/libreadline-gplv2-dev_5.2+dfsg-3+b13_amd64.deb
RUN apt-get update \
  && apt-get install -y \
      libreadline5
RUN dpkg -i libreadline-gplv2-dev_5.2+dfsg-3+b13_amd64.deb
RUN git clone https://github.com/MariaDB/server.git
RUN cd server \
  && echo checkout 10.3.39 \
  && git fetch \
  && git checkout mariadb-10.3.39
RUN cd server \
  && sed -i '118s/system/bundled/' cmake/build_configurations/mysql_release.cmake
RUN cd server \
  && sed -i '15s/GNUTLS/OPENSSL/' cmake/mariadb_connector_c.cmake
RUN cd server \
  && ./debian/autobake-deb.sh

FROM scratch

COPY --from=build-stage /*.deb .

