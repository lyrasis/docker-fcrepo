FROM maven:3.6.2-jdk-8 AS build

LABEL maintainer=mark.cooper@lyrasis.org

ENV LANG=C.UTF-8 \
    FCREPO_BRANCH="fcrepo-5.1.0" \
    FCREPO_URL=https://github.com/fcrepo4/fcrepo4.git \
    MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"

WORKDIR /
RUN git clone --single-branch --branch $FCREPO_BRANCH $FCREPO_URL

WORKDIR /fcrepo4
RUN mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V

FROM tomcat:8

ENV FCREPO_HOME=/opt/data \
    TOMCAT_WEBAPPS=/usr/local/tomcat/webapps

ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Dfcrepo.home=${FCREPO_HOME} -Dfcrepo.modeshape.configuration=classpath:/config/file-simple/repository.json"

COPY --from=build \
    /fcrepo4/fcrepo-webapp/target/fcrepo-webapp-*.war \
    $TOMCAT_WEBAPPS/fcrepo.war

RUN mkdir $FCREPO_HOME
ADD context.xml $TOMCAT_WEBAPPS/manager/META-INF/context.xml
ADD tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

VOLUME ["$FCREPO_HOME"]

HEALTHCHECK --interval=1m --timeout=5s --start-period=1m --retries=2 \
  CMD wget -q --user fedoraAdmin --password secret3 --spider http://localhost:8080/fcrepo/rest || exit 1

CMD ["catalina.sh", "run"]
