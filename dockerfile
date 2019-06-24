FROM apiman/on-wildfly11:1.5.1.Final

RUN echo '>>> before'
RUN echo $(ls -1 ${JBOSS_HOME}/standalone/configuration)

WORKDIR ${JBOSS_HOME}
ADD ./configuration/apiman.properties ${JBOSS_HOME}/standalone/configuration/
ADD ./configuration/standalone-apiman.xml ${JBOSS_HOME}/standalone/configuration/
ADD ./configuration/apiman.jks ${JBOSS_HOME}/standalone/configuration/
ADD ./configuration/copytest.txt ${JBOSS_HOME}/standalone/configuration/

RUN echo '--- Configuration'
RUN echo $(ls -1 ${JBOSS_HOME}/standalone/configuration)


# RUN rm -rf ${JBOSS_HOME}/standalone/deployments/apiman-es.war

ADD ./deployments/apiman-ds.xml ${JBOSS_HOME}/standalone/deployments/
ADD ./deployments/postgresql-9.3-1102-jdbc41.jar ${JBOSS_HOME}/standalone/deployments/

RUN echo '--- deployments'
RUN echo $(ls -1 ${JBOSS_HOME}/standalone/deployments)



USER root   

RUN chown -R jboss:0 ${JBOSS_HOME} \
 && chmod -R g+rw ${JBOSS_HOME}

USER jboss

# Set the default command to run on boot
ENTRYPOINT ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-apiman.xml"]