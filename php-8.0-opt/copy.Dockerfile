FROM lookshe/php-8.0-opt-build AS build-stage

FROM scratch AS export-stage
COPY --from=build-stage /php-8.0.0/php-8.0.0-opt_8.0.0-1_amd64.deb .
COPY --from=build-stage /libzip-0.11.2/php-8.0.0-opt-libzip_0.11.2-1_amd64.deb .
COPY --from=build-stage /icu/source/php-8.0.0-opt-icu_1-1_amd64.deb .
COPY --from=build-stage /oniguruma-6.9.6/php-8.0.0-opt-oniguruma_6.9.6-1_amd64.deb .
COPY --from=build-stage /libgd-2.1.1/php-8.0.0-opt-libgd_2.1.1-1_amd64.deb .
COPY --from=build-stage /libjpeg-turbo-2.0.6/build/php-8.0.0-opt-libjpeg-turbo_1-1_amd64.deb .
COPY --from=build-stage /krb5-1.17.2/src/php-8.0.0-opt-krb5_1-1_amd64.deb .
COPY --from=build-stage /php-8.0.0/ext/imagick-3.4.4/php-8.0.0-opt-imagick_3.4.4-1_amd64.deb .
COPY --from=build-stage /php-8.0.0/ext/apcu-5.1.19/php-8.0.0-opt-apcu_5.1.19-1_amd64.deb .
COPY --from=build-stage /libsodium-1.0.18/php-8.0.0-opt-libsodium_1.0.18-1_amd64.deb .

