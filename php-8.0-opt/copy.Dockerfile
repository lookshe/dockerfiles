FROM lookshe/php-8.0-opt-build AS build-stage

FROM scratch AS export-stage
COPY --from=build-stage /php-8.0.17/php-8.0.17-opt_8.0.17-1_amd64.deb .
COPY --from=build-stage /libzip-0.11.2/php-8.0.17-opt-libzip_0.11.2-1_amd64.deb .
COPY --from=build-stage /icu/source/php-8.0.17-opt-icu_1-1_amd64.deb .
COPY --from=build-stage /oniguruma-6.9.6/php-8.0.17-opt-oniguruma_6.9.6-1_amd64.deb .
COPY --from=build-stage /libgd-2.1.1/php-8.0.17-opt-libgd_2.1.1-1_amd64.deb .
COPY --from=build-stage /libjpeg-turbo-2.0.6/build/php-8.0.17-opt-libjpeg-turbo_1-1_amd64.deb .
COPY --from=build-stage /krb5-1.17.2/src/php-8.0.17-opt-krb5_1-1_amd64.deb .
COPY --from=build-stage /php-8.0.17/ext/imagick-3.5.1/php-8.0.17-opt-imagick_3.5.1-1_amd64.deb .
COPY --from=build-stage /php-8.0.17/ext/apcu-5.1.20/php-8.0.17-opt-apcu_5.1.20-1_amd64.deb .
COPY --from=build-stage /libsodium-1.0.18/php-8.0.17-opt-libsodium_1.0.18-1_amd64.deb .
COPY --from=build-stage /php-8.0.17/ext/php-memcached-3.1.5/php-8.0.17-opt-memcached_3.1.5-1_amd64.deb .
COPY --from=build-stage /php-8.0.17/ext/phpredis-5.3.4/php-8.0.17-opt-redis_5.3.4-1_amd64.deb .

