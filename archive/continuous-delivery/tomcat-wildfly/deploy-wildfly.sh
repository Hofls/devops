#!/usr/bin/env bash

PATH_TO_WILDFLY=$1;
WAR_NAME=$2;
CONTROLLER_PORT=$3

if  [[ ! -f ${PATH_TO_WILDFLY}"/"${WAR_NAME} ]]; then
  echo "Nothing to deploy. New war file wasn't found at "${PATH_TO_WILDFLY}"/"${WAR_NAME}
else
  echo "Copying new WAR file"
  mv ${PATH_TO_WILDFLY}/${WAR_NAME} ${PATH_TO_WILDFLY}/standalone/deployments/;
  echo "Restarting Wildfly (full restart, including JVM)"
  sh ${PATH_TO_WILDFLY}/bin/jboss-cli.sh --controller=localhost:${CONTROLLER_PORT} --connect -c ":shutdown(restart=true)"
  # its important to call shutdown(restart=true), otherwise you will get OutOfMemoryError after few redeployment cycles
fi
