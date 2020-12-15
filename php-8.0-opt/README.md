## PHP 8.0 for Debian Wheezy

PHP 8.0 as .deb file for installation in /opt and all dependencies as .deb files.

### Build

Build is done inside Debian Wheezy docker with
```
DOCKER_BUILDKIT=1 docker build --file build.Dockerfile --tag lookshe/php-8.0-opt-build .
```

### Get installation files

To copy the .deb files out of build container run
```
DOCKER_BUILDKIT=1 docker build --file copy.Dockerfile --output out .
```

