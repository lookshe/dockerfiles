FROM debian/eol:wheezy

ENV MAIN_PREFIX /opt/php-7.4
ENV DEP_PREFIX $MAIN_PREFIX/dependencies
ENV PACKAGE_NAME php-7.4.12-opt

RUN apt-get update \
  && apt-get install -y \
      curl \
      build-essential \
      net-tools \
      autoconf \
      pkg-config \
      wget \
      libxml2-dev \
      libkrb5-dev \
      libssl-dev \
      libsqlite3-dev \
      libbz2-dev \
      libcurl4-openssl-dev \
      libpng12-dev libjpeg8-dev \
      libfreetype6-dev \
      libc-client-dev \
      libpq-dev \
      libxslt1-dev \
      checkinstall \
      zlib1g-dev \
      libtool \
      bison \
      libgmp-dev \
      libtidy-dev \
      libgd2-xpm-dev \
      libmagickwand-dev \
      libmagickcore-dev
RUN wget https://cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
RUN tar xzf cmake-2.8.12.1.tar.gz
RUN cd cmake-2.8.12.1 \
  && ./bootstrap \
  && make \
  && make install
RUN wget https://github.com/libjpeg-turbo/libjpeg-turbo/archive/2.0.6.tar.gz -O libjpeg-turbo-2.0.6.tar.gz
RUN tar xzf libjpeg-turbo-2.0.6.tar.gz
RUN cd libjpeg-turbo-2.0.6 \
  && mkdir build \
  && cd build \
  && cmake -DCMAKE_INSTALL_PREFIX=$DEP_PREFIX -DCMAKE_BUILD_TYPE=RELEASE -DENABLE_STATIC=FALSE -DCMAKE_INSTALL_DEFAULT_LIBDIR=lib .. \
  && make \
  && checkinstall -y --pkgname $PACKAGE_NAME-libjpeg-turbo --pkgversion 1
RUN ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a
RUN wget https://web.mit.edu/kerberos/dist/krb5/1.17/krb5-1.17.2.tar.gz
RUN tar xzf krb5-1.17.2.tar.gz
RUN cd krb5-1.17.2/src \
  && ./configure --prefix=$DEP_PREFIX \
  && make \
  && checkinstall -y --pkgname $PACKAGE_NAME-krb5 --pkgversion 1
RUN wget https://github.com/unicode-org/icu/releases/download/release-50-2/icu4c-50_2-src.tgz
RUN tar xzf icu4c-50_2-src.tgz
RUN cd icu/source/ \
  && ./configure --prefix=$DEP_PREFIX \
  && make \
  && checkinstall -y --pkgname $PACKAGE_NAME-icu --pkgversion 1
RUN wget https://github.com/kkos/oniguruma/archive/v6.9.6.tar.gz
RUN tar xzf v6.9.6.tar.gz
RUN cd oniguruma-6.9.6 \
  && autoreconf -vfi \
  && ./configure --prefix=$DEP_PREFIX \
  && make \
  && checkinstall -y --pkgname $PACKAGE_NAME-oniguruma
RUN wget https://libzip.org/download/libzip-0.11.2.tar.gz
RUN tar xzf libzip-0.11.2.tar.gz
# in this case checkinstall only works after "make install"
RUN cd libzip-0.11.2 \
  && ./configure --prefix=$DEP_PREFIX \
  && make \
  && make install \
  && checkinstall -y --pkgname $PACKAGE_NAME-libzip
RUN wget https://github.com/libgd/libgd/releases/download/gd-2.1.1/libgd-2.1.1.tar.gz
RUN tar xzf libgd-2.1.1.tar.gz
RUN cd libgd-2.1.1 \
  && ./configure --prefix=$DEP_PREFIX \
  && make \
  && checkinstall -y --pkgname $PACKAGE_NAME-libgd
RUN curl https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz > libsodium-1.0.18.tar.gz
RUN tar xzf libsodium-1.0.18.tar.gz
RUN cd libsodium-1.0.18 \
  && ./configure --prefix=$DEP_PREFIX \
  && make \
  && checkinstall -y --pkgname $PACKAGE_NAME-libsodium
RUN wget https://www.php.net/distributions/php-7.4.12.tar.gz
RUN tar xzf php-7.4.12.tar.gz
RUN cd php-7.4.12 \
  && PKG_CONFIG_PATH=$DEP_PREFIX/lib/pkgconfig ./configure \
      --prefix=$MAIN_PREFIX \
      #--with-libdir=/lib/x86_64-linux-gnu \
      #--disable-rpath \
      --enable-static \
      --enable-bcmath \
      --enable-calendar \
      --enable-exif \
      --enable-fpm \
      --enable-ftp \
      --enable-gd \
      --enable-intl \
      --enable-mbstring \
      --enable-pcntl \
      --enable-pdo \
      --enable-shmop \
      --enable-soap \
      --enable-sockets \
      --enable-sysvsem \
      --enable-sysvshm \
      --enable-zip \
      --with-bz2 \
      --with-config-file-path=$MAIN_PREFIX/etc \
      --with-config-file-scan-dir=$MAIN_PREFIX/etc/conf.d \
      --with-curl \
      --with-external-gd \
      --with-freetype \
      --with-gettext \
      --with-gmp \
      #--with-imap=shared \
      #--with-imap-ssl \
      --with-jpeg \
      --with-kerberos \
      --with-ldap=shared \
      --with-mhash \
      --with-mysql-sock=/var/run/mysqld/mysqld.sock \
      --with-mysqli \
      --with-openssl \
      --with-pdo-mysql \
      --with-pdo-sqlite \
      --with-pear \
      --with-sodium \
      --with-sqlite3 \
      --with-tidy \
      --with-xmlrpc \
      --with-xpm \
      --with-xsl \
      --with-zip \
      --with-zlib \
  && make \
  && checkinstall -y --pkgname $PACKAGE_NAME
RUN cd /php-7.4.12/ext \
  && wget https://github.com/Imagick/imagick/archive/3.4.4.tar.gz \
  && tar xzf 3.4.4.tar.gz \
  && cd imagick-3.4.4 \
  && $MAIN_PREFIX/bin/phpize \
  && ./configure --with-php-config=$MAIN_PREFIX/bin/php-config \
  && make \
  && checkinstall -y -pkgname $PACKAGE_NAME-imagick
RUN cd /php-7.4.12/ext \
  && wget https://github.com/krakjoe/apcu/archive/v5.1.19.tar.gz \
  && tar xzf v5.1.19.tar.gz \
  && cd apcu-5.1.19 \
  && $MAIN_PREFIX/bin/phpize \
  && ./configure --with-php-config=$MAIN_PREFIX/bin/php-config \
  && make \
  && checkinstall -y -pkgname $PACKAGE_NAME-apcu

