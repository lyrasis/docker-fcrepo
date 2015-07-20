FROM ubuntu:trusty

MAINTAINER mark.cooper@lyrasis.org

ENV FCREPO_URL https://github.com/fcrepo4/fcrepo4.git
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV MAVEN_OPTS "-Xmx1024m -XX:MaxPermSize=1024m"

RUN apt-get -y install --no-install-recommends software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get -y install --no-install-recommends git maven openjdk-8-jdk

WORKDIR /
RUN git clone $FCREPO_URL

WORKDIR /fcrepo4
RUN mvn install

WORKDIR /fcrepo4/fcrepo-webapp

CMD ["mvn", "jetty:run"]
