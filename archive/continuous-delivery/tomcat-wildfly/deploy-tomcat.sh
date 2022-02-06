#!/usr/bin/env bash

PATH_TO_TOMCAT="$1";
WAR_NAME="$2";

if  [[ ! -f ${PATH_TO_TOMCAT}"/"${WAR_NAME} ]]; then
  echo "Nothing to deploy. New war file wasn't found at "${PATH_TO_TOMCAT}
else
  echo "Copying new WAR file"
  mv ${PATH_TO_TOMCAT}/${WAR_NAME} ${PATH_TO_TOMCAT}/webapps/;
  echo "Restarting Tomcat"
  systemctl restart tomcat-edition
fi
