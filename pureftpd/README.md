## Pure-FTPd to run with MariaDB 10.3 on Debian Wheezy

Rebuild Pure-FTPd due to following error message after using MariaDB 10.3 (should happen also with 10.2)
```
symbol my_make_scrambled_password, version libmysqlclient_18 not defined in file libmysqlclient.so.18 with link time reference
```
Implementation of make_scrambled_password is taken from MariaDB connectors.

### Build and get installation files

Build is done inside Debian Wheezy docker with
```
DOCKER_BUILDKIT=1 docker build --output out .
```
After this command the .deb-files are located in out folder.

