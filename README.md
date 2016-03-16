Docker Fedora 4
===============

[![](https://badge.imagelayers.io/lyrasis/fcrepo:4.5.0.svg)](https://imagelayers.io/?images=lyrasis/fcrepo:4.5.0 'Get your own badge on imagelayers.io')
[![Build Status](https://travis-ci.org/lyrasis/docker-fcrepo.svg?branch=master)](https://travis-ci.org/lyrasis/docker-fcrepo)

Run Fedora 4 using docker.

**Quickstart**

```bash
docker run --name fcrepo-data -d -v /opt/data lyrasis/fcrepo:4.5.0 true
docker run --name fcrepo -d -p 8080:8080 --volumes-from fcrepo-data lyrasis/fcrepo:4.5.0
docker logs -f fcrepo
```

Or, for a local volume mount instead of a data container:

```bash
mkdir fcrepo-data # the git repository has this folder already
chmod a+w fcrepo-data/ # give the container's jetty user permission to write
docker run --name fcrepo -d -p 8080:8080 -v $(pwd)/fcrepo-data:/opt/data lyrasis/fcrepo:4.5.0
docker logs -f fcrepo
```

For the latest (available) source build use `lyrasis/fcrepo:latest` for the image name.

Access (browser):

```
http://localhost:8080/fcrepo/rest
```

Access (container):

```bash
docker exec -it fcrepo /bin/bash
```

**Local build and run**

Clone this repository:

```bash
docker build -t fcrepo:4.5.0 4.5.0/
docker run --name fcrepo -d -p 8080:8080 fcrepo:4.5.0
docker logs -f fcrepo
```

Latest:

```bash
docker build -t fcrepo:latest latest/
docker run --name fcrepo-dev -d -p 9999:8080 fcrepo:latest
docker logs -f fcrepo-dev
```

---
