# Use WildFly 11 image as the base
FROM jboss/wildfly:11.0.0.Final

MAINTAINER Marc Savy <marc.savy@redhat.com>

ENV APIMAN_VERSION 1.5.1.Final

WORKDIR /wildfly
COPY . ./opt/jboss/wildfly/

USER root

RUN chown -R jboss:0 ${JBOSS_HOME} \
 && chmod -R g+rw ${JBOSS_HOME}

USER jboss

# Set the default command to run on boot
ENTRYPOINT ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-apiman.xml"]