#!/bin/bash
# Provides: goiardi
# Short-Description: goiardi
# Default-Start: 3 4 5
# Default-Stop: 0 1 2 6
# Required-Start:
# Required-Stop:
# Should-Start:
# Should-Stop:
# chkconfig: 2345 95 20
# description: goiardi server
# processname: goiardi
### END INIT INFO

NAME="goiardi"
GOIARDI_BINARY='/opt/goiardi/bin/goiardi'
GOIARDI_LOG='/opt/goiardi/log/goiardi.log'
GOIARDI_CONF_FILE='/opt/goiardi/etc/goiardi.conf'
GOIARDI_USER='goiardi'

SLEEP_TIME=5
CURRENT_WAIT=0
TIMEOUT=30

start() {
  findPid
  if [ -z "$FOUND_PID" ]; then
    su $GOIARDI_USER -c "$GOIARDI_BINARY -c $GOIARDI_CONF_FILE >> /dev/null 2>&1 &"
    if [[ $? -ne 0 ]]; then
      echo "Error starting $NAME"
      exit 1
    fi
    echo "$NAME successfully started"
  else
    echo "$NAME is already running"
  fi
}

stop() {
  findPid
  if [ -z "$FOUND_PID" ]; then
    echo "$NAME is not running, nothing to stop"
  else
    while [[ -n $FOUND_PID ]];
    do
      echo "Attempting to shutdown $NAME..."
      kill -INT $FOUND_PID
      if [[ $? -ne 0 ]]; then
        echo "Error stopping $NAME"
        exit 1
      fi
      sleep $SLEEP_TIME
      CURRENT_WAIT=$(($CURRENT_WAIT+$SLEEP_TIME))
      if [[ $CURRENT_WAIT -gt $TIMEOUT ]]; then
        echo "Timed out waiting for $NAME to stop"
        exit 1
      fi
      findPid
    done
    echo "Stopped $NAME"
  fi
}

status() {
  findPid
  if [ -z "$FOUND_PID" ]; then
    echo "$NAME is not running" ; exit 1
  else
    echo "$NAME is running : $FOUND_PID"
  fi
}

reload() {
  findPid
  if [ -z "$FOUND_PID" ]; then
    echo "$NAME is not running" ; exit 1
  else
    su -l $GOIARDI_USER -c "kill -HUP $FOUND_PID"
    echo "Reloaded $NAME"
  fi
}

findPid() {
  FOUND_PID=`pgrep -f $GOIARDI_BINARY`
}

case "$1" in
  start)
    start
  ;;
  stop)
    stop
  ;;
  restart)
    stop
    start
  ;;
  status)
    status
  ;;
  reload)
    reload
  ;;
  *)
    echo "Usage: $0 {start|stop|restart|status|reload}"
    exit 1
esac

exit 0
