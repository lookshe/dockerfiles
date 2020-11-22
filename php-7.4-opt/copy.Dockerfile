FROM lookshe/php-7.4-opt-build AS build-stage

FROM scratch AS export-stage
COPY --from=build-stage /php-7.4.12/php-7.4.12-opt_7.4.12-1_amd64.deb .
COPY --from=build-stage /libzip-0.11.2/php-7.4.12-opt-libzip_0.11.2-1_amd64.deb .
COPY --from=build-stage /icu/source/php-7.4.12-opt-icu_1-1_amd64.deb .
COPY --from=build-stage /oniguruma-6.9.6/php-7.4.12-opt-oniguruma_6.9.6-1_amd64.deb .
COPY --from=build-stage /libgd-2.1.1/php-7.4.12-opt-libgd_2.1.1-1_amd64.deb .
COPY --from=build-stage /libjpeg-turbo-2.0.6/build/php-7.4.12-opt-libjpeg-turbo_1-1_amd64.deb .
COPY --from=build-stage /krb5-1.17.2/src/php-7.4.12-opt-krb5_1-1_amd64.deb .

