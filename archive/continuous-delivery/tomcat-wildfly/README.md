# application-server-cd
Continuous delivery for Wildfly/Tomcat. Automatically deploys new version of application on the server.

The reason why CI cant be done with commands such as `nohup /opt/tomcat/bin/startup.sh &` or `nohup /wildfly/standalone/standalone.sh &` 
is because on exit, CI session kills all the processes spawned by it. 
Workaround is to not create any processes, but rather use services or send commands to existing processes.

## Wildfly:
* On server side:
    * Set environment variables:
        * `echo "export JAVA_HOME=/opt/jre1.8.0_211" >> ~/.bashrc`
        * `echo "export PATH=/opt/jre1.8.0_211/bin:${PATH}" >> ~/.bashrc`
    * Check if `jboss-cli.sh` is working:
        * `nohup /opt/wildfly/bin/standalone.sh &`
        * `sh /opt/wildfly/bin/jboss-cli.sh --connect command=:reload`

## Tomcat:
* On server side:
    * Copy file `tomcat.service` to directory `/etc/systemd/system/tomcat.service`
    * Reload daemon `systemctl daemon-reload`
    * Enable service `systemctl enable tomcat`
    * Check if service was created successfully: 
        * `systemctl start tomcat`
        * `systemctl status tomcat`
