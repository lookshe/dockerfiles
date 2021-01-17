FROM debian/eol:wheezy

RUN apt-get update \
  && apt-get install -y \
      software-properties-common \
      devscripts
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 CBCB082A1BB943DB
RUN echo "deb http://mirror2.hs-esslingen.de/mariadb/repo/10.3/debian wheezy main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirror2.hs-esslingen.de/mariadb/repo/10.3/debian wheezy main" >> /etc/apt/sources.list
RUN apt-get update \
  && apt-get build-dep -y mariadb-server-10.3
RUN git clone https://github.com/MariaDB/server.git
RUN cd server \
  && git checkout mariadb-10.3.27
RUN apt-get update \
  && apt-get install -y \
      dh-exec
RUN cd server \
  && ./debian/autobake-deb.sh

