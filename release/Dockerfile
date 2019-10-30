FROM tomcat:8

LABEL maintainer=mark.cooper@lyrasis.org

ENV FCREPO_HOME=/opt/data \
    FCREPO_NAME=fcrepo \
    FCREPO_VERSION=${SOURCE_BRANCH:-5.1.0} \
    TOMCAT_WEBAPPS=/usr/local/tomcat/webapps

ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Dfcrepo.home=${FCREPO_HOME} -Dfcrepo.modeshape.configuration=classpath:/config/file-simple/repository.json" \
    FCREPO_URL=https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-${FCREPO_VERSION}/fcrepo-webapp-${FCREPO_VERSION}.war

RUN wget -O ${TOMCAT_WEBAPPS}/${FCREPO_NAME}.war $FCREPO_URL
RUN mkdir $FCREPO_HOME
ADD context.xml $TOMCAT_WEBAPPS/manager/META-INF/context.xml
ADD tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

VOLUME ["$FCREPO_HOME"]

HEALTHCHECK --interval=1m --timeout=5s --start-period=1m --retries=2 \
  CMD wget -q --spider http://localhost:8080/fcrepo/rest || exit 1

CMD ["catalina.sh", "run"]
