FROM ubuntu:xenial

MAINTAINER mark.cooper@lyrasis.org

ENV LANG=C.UTF-8 \
  FCREPO_HOME=/opt/data \
  FCREPO_URL=https://github.com/fcrepo4/fcrepo4.git \
  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
  MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"

ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Dfcrepo.home=${FCREPO_HOME} -Dfcrepo.modeshape.configuration=classpath:/config/file-simple/repository.json"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get -y install --no-install-recommends git maven openjdk-8-jdk

WORKDIR /
RUN git clone $FCREPO_URL

WORKDIR /fcrepo4
RUN mvn install

WORKDIR /fcrepo4/fcrepo-webapp
RUN mkdir $FCREPO_HOME && chown -R jetty:jetty $FCREPO_HOME

CMD ["mvn","jetty:run"]
