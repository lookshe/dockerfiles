FROM lookshe/php-7.4-opt-build AS build-stage

FROM scratch AS export-stage
COPY --from=build-stage /php-7.4.28/php-7.4.28-opt_7.4.28-1_amd64.deb .
COPY --from=build-stage /libzip-0.11.2/php-7.4.28-opt-libzip_0.11.2-1_amd64.deb .
COPY --from=build-stage /icu/source/php-7.4.28-opt-icu_1-1_amd64.deb .
COPY --from=build-stage /oniguruma-6.9.6/php-7.4.28-opt-oniguruma_6.9.6-1_amd64.deb .
COPY --from=build-stage /libgd-2.1.1/php-7.4.28-opt-libgd_2.1.1-1_amd64.deb .
COPY --from=build-stage /libjpeg-turbo-2.0.6/build/php-7.4.28-opt-libjpeg-turbo_1-1_amd64.deb .
COPY --from=build-stage /krb5-1.17.2/src/php-7.4.28-opt-krb5_1-1_amd64.deb .
COPY --from=build-stage /php-7.4.28/ext/imagick-3.4.4/php-7.4.28-opt-imagick_3.4.4-1_amd64.deb .
COPY --from=build-stage /php-7.4.28/ext/apcu-5.1.20/php-7.4.28-opt-apcu_5.1.20-1_amd64.deb .
COPY --from=build-stage /libsodium-1.0.18/php-7.4.28-opt-libsodium_1.0.18-1_amd64.deb .
COPY --from=build-stage /php-7.4.28/ext/php-memcached-3.1.5/php-7.4.28-opt-memcached_3.1.5-1_amd64.deb .
COPY --from=build-stage /php-7.4.28/ext/phpredis-5.3.4/php-7.4.28-opt-redis_5.3.4-1_amd64.deb .

