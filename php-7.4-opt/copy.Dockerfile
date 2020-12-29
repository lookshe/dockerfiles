FROM lookshe/php-7.4-opt-build AS build-stage

FROM scratch AS export-stage
COPY --from=build-stage /php-7.4.12/php-7.4.12-opt_7.4.12-1_amd64.deb .
COPY --from=build-stage /libzip-0.11.2/php-7.4.12-opt-libzip_0.11.2-1_amd64.deb .
COPY --from=build-stage /icu/source/php-7.4.12-opt-icu_1-1_amd64.deb .
COPY --from=build-stage /oniguruma-6.9.6/php-7.4.12-opt-oniguruma_6.9.6-1_amd64.deb .
COPY --from=build-stage /libgd-2.1.1/php-7.4.12-opt-libgd_2.1.1-1_amd64.deb .
COPY --from=build-stage /libjpeg-turbo-2.0.6/build/php-7.4.12-opt-libjpeg-turbo_1-1_amd64.deb .
COPY --from=build-stage /krb5-1.17.2/src/php-7.4.12-opt-krb5_1-1_amd64.deb .
COPY --from=build-stage /php-7.4.12/ext/imagick-3.4.4/php-7.4.12-opt-imagick_3.4.4-1_amd64.deb .
COPY --from=build-stage /php-7.4.12/ext/apcu-5.1.19/php-7.4.12-opt-apcu_5.1.19-1_amd64.deb .
COPY --from=build-stage /libsodium-1.0.18/php-7.4.12-opt-libsodium_1.0.18-1_amd64.deb .
COPY --from=build-stage /php-7.4.12/ext/php-memcached-3.1.5/php-7.4.12-opt-memcached_3.1.5-1_amd64.deb .

