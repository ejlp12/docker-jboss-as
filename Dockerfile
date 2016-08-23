FROM anapsix/alpine-java:8_server-jre_unlimited
MAINTAINER daniele franceschi netserv it

# install utilities
RUN apk add --no-cache curl && \
# install jboss
    curl -SL -o /tmp/jboss713.tar.gz https://bintray.com/matf/jboss-wildfly/download_file?file_path=jboss-as%2F7.1.3.Final%2Fjboss-as-7.1.3.Final.tar.gz && \
    tar zxvf /tmp/jboss713.tar.gz -C /opt && \
    rm -f /tmp/jboss713.tar.gz
# configuration
RUN  sed -i -r 's/jboss.bind.address.management:127.0.0.1/jboss.bind.address.management:0.0.0.0/' \
       /opt/jboss-as-7.1.3.Final/standalone/configuration/standalone.xml

# expose ports
EXPOSE 8080 9990

# expose deployments volume for first decade conservatives
VOLUME /opt/jboss-as-7.1.3.Final/standalone/deployments

# script to start the container
ADD jboss_run.sh /jboss_run.sh
RUN chmod 755 /*.sh
CMD ["/jboss_run.sh"]

