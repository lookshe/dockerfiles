FROM debian/eol:wheezy AS build-stage

RUN echo "deb http://archive.debian.org/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.debian.org/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update \
  && apt-get install -y \
      software-properties-common
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 CBCB082A1BB943DB
RUN echo "deb http://mirror2.hs-esslingen.de/mariadb/repo/10.3/debian wheezy main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirror2.hs-esslingen.de/mariadb/repo/10.3/debian wheezy main" >> /etc/apt/sources.list
RUN apt-get update \
  && apt-get install -y \
      build-essential \
      fakeroot \
      dpkg-dev \
      autoconf-archive \
      libcap2-dev \
#      libmysqlclient-dev \
      libmariadb-dev-compat \
      po-debconf \
      debhelper \
      wget \
      libpam-dev \
      libldap2-dev \
      libpq-dev \
      libssl-dev
RUN mkdir pure-ftp-1.0.36-1.1
RUN cd pure-ftp-1.0.36-1.1
RUN wget http://archive.debian.org/debian/pool/main/p/pure-ftpd/pure-ftpd_1.0.36-1.1.dsc
RUN wget http://archive.debian.org/debian/pool/main/p/pure-ftpd/pure-ftpd_1.0.36.orig.tar.gz
RUN wget http://archive.debian.org/debian/pool/main/p/pure-ftpd/pure-ftpd_1.0.36-1.1.diff.gz
RUN tar zxvf pure-ftpd_1.0.36.orig.tar.gz
RUN mv pure-ftpd-1.0.36.orig/ pure-ftpd-1.0.36
RUN mkdir pure-ftpd-1.0.36/debian
RUN gunzip pure-ftpd_1.0.36-1.1.diff.gz
RUN patch -p0 < pure-ftpd_1.0.36-1.1.diff
RUN echo "--- pure-ftpd-1.0.36.orig/src/log_mysql.c       2012-03-16 01:01:37.000000000 +0000" >> self_implemented_make_scrambled_password.diff \
  && echo "+++ pure-ftpd-1.0.36/src/log_mysql.c    2021-01-24 20:59:29.749460231 +0000" >> self_implemented_make_scrambled_password.diff \
  && echo "@@ -460,7 +460,25 @@ void pw_mysql_check(AuthResult * const r" >> self_implemented_make_scrambled_password.diff \
  && echo "         my_make_scrambled_password(scrambled_password, password," >> self_implemented_make_scrambled_password.diff \
  && echo "                                    strlen(password));" >> self_implemented_make_scrambled_password.diff \
  && echo " #  else" >> self_implemented_make_scrambled_password.diff \
  && echo "-        make_scrambled_password(scrambled_password, password);" >> self_implemented_make_scrambled_password.diff \
  && echo "+{" >> self_implemented_make_scrambled_password.diff \
  && echo "+  ulong hash_res[2];" >> self_implemented_make_scrambled_password.diff \
  && echo "+  size_t len = strlen(password);" >> self_implemented_make_scrambled_password.diff \
  && echo "+  ulong nr=1345345333L, add=7, nr2=0x12345671L;" >> self_implemented_make_scrambled_password.diff \
  && echo "+  ulong tmp;" >> self_implemented_make_scrambled_password.diff \
  && echo "+  const char *password_end= password + len;" >> self_implemented_make_scrambled_password.diff \
  && echo "+  for (; password < password_end; password++)" >> self_implemented_make_scrambled_password.diff \
  && echo "+  {" >> self_implemented_make_scrambled_password.diff \
  && echo "+    if (*password == ' ' || *password == '\t')" >> self_implemented_make_scrambled_password.diff \
  && echo "+      continue;                        /* skipp space in password */" >> self_implemented_make_scrambled_password.diff \
  && echo "+    tmp= (ulong) (unsigned char) *password;" >> self_implemented_make_scrambled_password.diff \
  && echo "+    nr^= (((nr & 63)+add)*tmp)+ (nr << 8);" >> self_implemented_make_scrambled_password.diff \
  && echo "+    nr2+=(nr2 << 8) ^ nr;" >> self_implemented_make_scrambled_password.diff \
  && echo "+    add+=tmp;" >> self_implemented_make_scrambled_password.diff \
  && echo "+  }" >> self_implemented_make_scrambled_password.diff \
  && echo "+  hash_res[0]=nr & (((ulong) 1L << 31) -1L); /* Don't use sign bit (str2int) */;" >> self_implemented_make_scrambled_password.diff \
  && echo "+  hash_res[1]=nr2 & (((ulong) 1L << 31) -1L);" >> self_implemented_make_scrambled_password.diff \
  && echo "+  sprintf(scrambled_password,\"%08lx%08lx\",hash_res[0],hash_res[1]);" >> self_implemented_make_scrambled_password.diff \
  && echo "+}" >> self_implemented_make_scrambled_password.diff \
  && echo " #  endif" >> self_implemented_make_scrambled_password.diff \
  && echo " # endif" >> self_implemented_make_scrambled_password.diff \
  && echo " #endif" >> self_implemented_make_scrambled_password.diff \
  && echo "" >> self_implemented_make_scrambled_password.diff
RUN patch -p0 < self_implemented_make_scrambled_password.diff
RUN chmod +x pure-ftpd-1.0.36/debian/rules
RUN cd pure-ftpd-1.0.36/ \
  && dpkg-buildpackage -uc -b

FROM scratch

COPY --from=build-stage /*.deb .

