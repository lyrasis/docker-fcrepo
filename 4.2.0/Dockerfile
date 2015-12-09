FROM jetty:9-jre8

MAINTAINER mark.cooper@lyrasis.org

ENV FCREPO_HOME /opt/data
ENV FCREPO_NAME fcrepo
ENV FCREPO_VERSION 4.2.0
ENV FCREPO_URL https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-${FCREPO_VERSION}/fcrepo-webapp-${FCREPO_VERSION}.war
ENV JETTY_WEBAPPS /var/lib/jetty/webapps

RUN wget -O ${JETTY_WEBAPPS}/${FCREPO_NAME}.war $FCREPO_URL
RUN mkdir $FCREPO_HOME && chown -R jetty:jetty $FCREPO_HOME

VOLUME ["$FCREPO_HOME"]

CMD ["java","-Dfcrepo.home=/opt/data","-jar","/usr/local/jetty/start.jar"]
