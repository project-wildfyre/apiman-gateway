FROM apiman/on-wildfly10:1.5.1.Final


RUN echo $(ls -1 /opt/jboss/wildfly)

WORKDIR wildfly
ADD ./configuration/apiman.properties /opt/jboss/wildfly/standalone/configuration/
ADD ./configuration/standalone-apiman.xml /opt/jboss/wildfly/standalone/configuration/

RUN echo $(ls -1 /opt/jboss/wildfly)

USER root

RUN chown -R jboss:0 ${JBOSS_HOME} \
 && chmod -R g+rw ${JBOSS_HOME}

USER jboss

# Set the default command to run on boot
ENTRYPOINT ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-apiman.xml"]