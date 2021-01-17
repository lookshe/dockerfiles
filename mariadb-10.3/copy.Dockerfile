FROM lookshe/mariadb-10.3-build AS build-stage

FROM scratch AS export-stage
COPY --from=build-stage /*.deb .

