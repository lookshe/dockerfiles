## MariaDB 10.3 for Debian Wheezy

Build latest tag of MariaDB 10.3 for Debian Wheezy.

### Build

Build is done inside Debian Wheezy docker with
```
DOCKER_BUILDKIT=1 docker build --file build.Dockerfile --tag lookshe/mariadb-10.3-build .
```

### Get installation files

To copy the .deb files out of build container run
```
DOCKER_BUILDKIT=1 docker build --file copy.Dockerfile --output out .
```

