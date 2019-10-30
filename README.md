# Docker Fedora Commons

[![Build Status](https://travis-ci.org/lyrasis/docker-fcrepo.svg?branch=master)](https://travis-ci.org/lyrasis/docker-fcrepo)

Run Fedora Commons using docker.

## Quickstart

```bash
VERSION=latest

# option 1. standard docker run:
docker run --name fcrepo -d -p 8080:8080 lyrasis/fcrepo:$VERSION

# option 2. with a data volume container:
docker run --name fcrepo-data -d -v /opt/data lyrasis/fcrepo:$VERSION true
docker run --name fcrepo -d -p 8080:8080 --volumes-from fcrepo-data lyrasis/fcrepo:$VERSION

# option 3. with a local volume mount:
docker run --name fcrepo -d -p 8080:8080 -v $(pwd)/fcrepo-data:/opt/data lyrasis/fcrepo:$VERSION
```

Access Fedora Commons ([credentials](release/tomcat-users.xml)):

```
http://localhost:8080/fcrepo/rest
```

Access the running container:

```bash
docker exec -it fcrepo bash
```

Viewing the Logs:

```
docker logs -f fcrepo
```

## Local build and run

```bash
CURRENT_RELEASE=5.1.0
docker build -t fcrepo:${CURRENT_RELEASE} release/
docker run --name fcrepo -d -p 8080:8080 fcrepo:${CURRENT_RELEASE}
docker logs -f fcrepo
```

To push this to docker hub follow the standard [docs](https://docs.docker.com/docker-cloud/builds/push-images/):

```bash
docker tag fcrepo:$VERSION $DOCKER_ID_USER/fcrepo:$VERSION
docker push $DOCKER_ID_USER/fcrepo:$VERSION
```

Latest:

```bash
docker build -t fcrepo:latest build/
docker run --name fcrepo -d -p 8080:8080 fcrepo:latest
docker logs -f fcrepo
```

## Using a production standard database

```bash
IMAGE=lyrasis/fcrepo:latest
./run_with_db.sh $IMAGE
```

See [Configuring JDBC Object Store](https://wiki.duraspace.org/display/FEDORA4x/Configuring+JDBC+Object+Store) for other options.

## Configuration

Refer to the [Best Practices](https://wiki.duraspace.org/display/FEDORA4x/Best+Practices+-+Fedora+Configuration).

---
