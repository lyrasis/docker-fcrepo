# Docker Fedora 4

[![](https://badge.imagelayers.io/lyrasis/fcrepo:4.7.4.svg)](https://imagelayers.io/?images=lyrasis/fcrepo:4.7.4 'Get your own badge on imagelayers.io')
[![Build Status](https://travis-ci.org/lyrasis/docker-fcrepo.svg?branch=master)](https://travis-ci.org/lyrasis/docker-fcrepo)

Run Fedora 4 using docker.

## Quickstart

```bash
docker run --name fcrepo -d -p 8080:8080 lyrasis/fcrepo:4.7.4
```

Or, with a data volume container:

```
docker run --name fcrepo-data -d -v /opt/data lyrasis/fcrepo:4.7.4 true
docker run --name fcrepo -d -p 8080:8080 --volumes-from fcrepo-data lyrasis/fcrepo:4.7.4
```

Or, with a local volume mount:

```bash
mkdir fcrepo-data # the git repository has this folder already
chmod a+w fcrepo-data/ # give the container's jetty user permission to write
docker run --name fcrepo -d -p 8080:8080 -v $(pwd)/fcrepo-data:/opt/data lyrasis/fcrepo:4.7.4
```

For the latest (available) source build use `lyrasis/fcrepo:latest` for the image name.

Access (browser):

```
http://localhost:8080/fcrepo/rest
```

Access (container):

```bash
docker exec -it fcrepo bash
```

Logs:

```
docker logs -f fcrepo
```

## Using a production standard database

```
# note: we're skipping Docker network creation
# start a MySQL container
docker run -d \
  -p 3306:3306 \
  --name mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=fcrepo \
  -e MYSQL_USER=fcrepo \
  -e MYSQL_PASSWORD=fcrepo \
  mysql:5.7 --innodb_buffer_pool_size=4G --innodb_buffer_pool_instances=4

MYSQL_ADDR=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql)

JAVA_OPTIONS="${JAVA_OPTIONS} -Djetty.http.port=9999"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dfile.encoding=UTF-8"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dfcrepo.home=/opt/data"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dfcrepo.modeshape.configuration=classpath:/config/jdbc-mysql/repository.json"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dfcrepo.mysql.username=fcrepo"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dfcrepo.mysql.password=fcrepo"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dfcrepo.mysql.host=${MYSQL_ADDR}"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dfcrepo.mysql.port=3306"

docker run --name fcrepo -e JAVA_OPTIONS="${JAVA_OPTIONS}" -d -p 9999:9999 lyrasis/fcrepo:4.7.4
```

See [Configuring JDBC Object Store](https://wiki.duraspace.org/display/FEDORA4x/Configuring+JDBC+Object+Store) for other options.

## Local build and run

Clone this repository:

```bash
docker build -t fcrepo:4.7.4 4.7.4/
docker run --name fcrepo -d -p 8080:8080 fcrepo:4.7.4
docker logs -f fcrepo
```

Latest:

```bash
docker build -t fcrepo:latest latest/
docker run --name fcrepo-dev -d -p 9999:8080 fcrepo:latest
docker logs -f fcrepo-dev
```

## Configuration

Refer to the [Best Practices](https://wiki.duraspace.org/display/FEDORA4x/Best+Practices+-+Fedora+Configuration).

---
