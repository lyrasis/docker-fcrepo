#!/bin/bash

IMAGE=${1:-"fcrepo:5.1.0"}

docker stop fcrepo && docker rm -f fcrepo || true

# note: we're skipping Docker network creation
docker run -d \
  -p 3306:3306 \
  --name mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=fcrepo \
  -e MYSQL_USER=fcrepo \
  -e MYSQL_PASSWORD=fcrepo \
  mysql:5.7 --innodb_buffer_pool_size=2G --innodb_buffer_pool_instances=2 || true

MYSQL_ADDR=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql)

JAVA_OPTS="${JAVA_OPTS} -Dfile.encoding=UTF-8"
JAVA_OPTS="${JAVA_OPTS} -Dfcrepo.home=/opt/data"
JAVA_OPTS="${JAVA_OPTS} -Dfcrepo.modeshape.configuration=classpath:/config/jdbc-mysql/repository.json"
JAVA_OPTS="${JAVA_OPTS} -Dfcrepo.mysql.username=fcrepo"
JAVA_OPTS="${JAVA_OPTS} -Dfcrepo.mysql.password=fcrepo"
JAVA_OPTS="${JAVA_OPTS} -Dfcrepo.mysql.host=${MYSQL_ADDR}"
JAVA_OPTS="${JAVA_OPTS} -Dfcrepo.mysql.port=3306"

docker run --name fcrepo \
  -d \
  -e JAVA_OPTS="${JAVA_OPTS}" \
  -p 8081:8080 \
  --restart on-failure \
  $IMAGE
