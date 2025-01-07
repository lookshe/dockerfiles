## MariaDB 10.3 for Debian Bookworm

Build latest tag of MariaDB 10.3 for Debian Bookworm.

### Build

Build is done inside Debian Bookworm docker with
```
DOCKER_BUILDKIT=1 podman build --output out .
```

### Upload installation files in repository

Upload the .deb files to repository with
```
export REPO_TOKEN=xyz
export USERNAME=lookshe
for DEB in $(ls out/*.deb)
do
  curl -H "Authorization: token $REPO_TOKEN" \
  --upload-file "$DEB" \
  "https://git.fucktheforce.de/api/packages/$USERNAME/debian/pool/bookworm/main/upload"
done
```

