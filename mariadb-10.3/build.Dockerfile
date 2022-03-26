FROM debian/eol:wheezy

RUN apt-get update \
  && apt-get install -y \
      software-properties-common \
      devscripts \
      dh-exec \
      wget
RUN wget https://cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
RUN tar xzf cmake-2.8.12.1.tar.gz
RUN cd cmake-2.8.12.1 \
  && ./bootstrap \
  && make \
  && make install
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 CBCB082A1BB943DB
RUN echo "deb http://mirror2.hs-esslingen.de/mariadb/repo/10.3/debian wheezy main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirror2.hs-esslingen.de/mariadb/repo/10.3/debian wheezy main" >> /etc/apt/sources.list
RUN apt-get update \
  && apt-get build-dep -y mariadb-server-10.3
RUN git clone https://github.com/MariaDB/server.git
RUN cd server \
  && echo checkout 10.3.34 \
  && git fetch \
  && git checkout mariadb-10.3.34 \
  && git checkout mariadb-10.3.28 debian/control \
  && git checkout mariadb-10.3.30 cmake/submodules.cmake
RUN cd server \
  && ./debian/autobake-deb.sh

