FROM lookshe/php-8.1-opt-build AS build-stage

FROM scratch AS export-stage
COPY --from=build-stage /php-8.1.4/php-8.1.4-opt_8.1.4-1_amd64.deb .
COPY --from=build-stage /libzip-0.11.2/php-8.1.4-opt-libzip_0.11.2-1_amd64.deb .
COPY --from=build-stage /icu/source/php-8.1.4-opt-icu_1-1_amd64.deb .
COPY --from=build-stage /oniguruma-6.9.6/php-8.1.4-opt-oniguruma_6.9.6-1_amd64.deb .
COPY --from=build-stage /libgd-2.1.1/php-8.1.4-opt-libgd_2.1.1-1_amd64.deb .
COPY --from=build-stage /libjpeg-turbo-2.0.6/build/php-8.1.4-opt-libjpeg-turbo_1-1_amd64.deb .
COPY --from=build-stage /krb5-1.17.2/src/php-8.1.4-opt-krb5_1-1_amd64.deb .
COPY --from=build-stage /php-8.1.4/ext/imagick-3.5.1/php-8.1.4-opt-imagick_3.5.1-1_amd64.deb .
COPY --from=build-stage /php-8.1.4/ext/apcu-5.1.20/php-8.1.4-opt-apcu_5.1.20-1_amd64.deb .
COPY --from=build-stage /libsodium-1.0.18/php-8.1.4-opt-libsodium_1.0.18-1_amd64.deb .
COPY --from=build-stage /libxml2-v2.9.10/php-8.1.4-opt-libxml2_2.9.10-1_amd64.deb .
COPY --from=build-stage /openssl-1.1.1n/php-8.1.4-opt-openssl_1.1.1n-1_amd64.deb .
COPY --from=build-stage /php-8.1.4/ext/php-memcached-3.1.5/php-8.1.4-opt-memcached_3.1.5-1_amd64.deb .
COPY --from=build-stage /php-8.1.4/ext/phpredis-5.3.4/php-8.1.4-opt-redis_5.3.4-1_amd64.deb .

