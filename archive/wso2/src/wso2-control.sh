#! /bin/sh
export JAVA_HOME="/opt/jdk-17.0.2"
startcmd='/opt/wso2am-4.2.0/bin/api-manager.sh start > /dev/null &'
restartcmd='/opt/wso2am-4.2.0/bin/api-manager.sh restart > /dev/null &'
stopcmd='/opt/wso2am-4.2.0/bin/api-manager.sh stop > /dev/null &'

case "$1" in
start)
   echo "Starting the WSO2 Server ..."
   su -c "${startcmd}"
;;
restart)
   echo "Re-starting the WSO2 Server ..."
   su -c "${restartcmd}"
;;
stop)
   echo "Stopping the WSO2 Server ..."
   su -c "${stopcmd}"
;;
*)
   echo "Usage: $0 {start|stop|restart}"
exit 1
esac