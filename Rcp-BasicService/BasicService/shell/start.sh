#!/bin/bash

cd `dirname $0`
BIN_DIR=`pwd`
cd ..
DEPLOY_DIR=`pwd`
CONF_DIR=$DEPLOY_DIR/conf

CONFIG_FILE=$BIN_DIR/env.cfg

SERVER_NAME=`sed '/^SERVER_NAME/!d;s/[^=]*=//' $CONFIG_FILE | tr -d '\r'`

MAIN_CLASS=`sed '/^MAIN_CLASS/!d;s/[^=]*=//' $CONFIG_FILE | tr -d '\r'`

JDK_HOME=`sed '/^JDK_HOME/!d;s/[^=]*=//' $CONFIG_FILE | tr -d '\r'`

JAVA_OPTS=`sed '/^JAVA_OPTS/!d;s/[^=]*=//' $CONFIG_FILE | tr -d '\r'`

JAVA_OPTS_64=`sed '/^JAVA_OPTS_64/!d;s/[^=]*=//' $CONFIG_FILE | tr -d '\r'`

STDOUT=`sed '/^STDOUT/!d;s/[^=]*=//' $CONFIG_FILE | tr -d '\r'`


if [ -z "$SERVER_NAME" ]; then
    SERVER_NAME=`hostname`
fi

PIDS=`ps -ef | grep java | grep "$CONF_DIR" |awk '{print $2}'`
if [ -n "$PIDS" ]; then
    echo "ERROR: The $SERVER_NAME already started!"
    echo "PID: $PIDS"
    exit 1
fi

if [ -z "$JDK_HOME" ]; then
	JDK_HOME="$JAVA_HOME"
fi

if [ -z "$JDK_HOME" ]; then
    echo "The JAVA_HOME environment variable is not defined correctly"
    echo "This environment variable is needed to run this program"
    exit 1
fi

_RUNJAVA="$JDK_HOME"/bin/java

LOGS_DIR=$DEPLOY_DIR/logs

if [ ! -d $LOGS_DIR ]; then
    mkdir $LOGS_DIR
fi


LIB_DIR=$DEPLOY_DIR/lib
LIB_JARS=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"`

JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true "
JAVA_DEBUG_OPTS=""
if [ "$1" = "debug" ]; then
    JAVA_DEBUG_OPTS=" -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n "
fi
JAVA_JMX_OPTS=""
if [ "$1" = "jmx" ]; then
    JAVA_JMX_OPTS=" -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false "
fi

JAVA_MEM_OPTS=""
BITS=`$_RUNJAVA -version 2>&1 | grep -i 64-bit`
if [ -n "$BITS" ]; then
    JAVA_MEM_OPTS=" $JAVA_OPTS_64 "
else
    JAVA_MEM_OPTS=" $JAVA_OPTS "
fi

echo -e "Starting the $SERVER_NAME ...\c"
nohup $_RUNJAVA $JAVA_OPTS $JAVA_MEM_OPTS $JAVA_DEBUG_OPTS $JAVA_JMX_OPTS -classpath $CONF_DIR:$LIB_JARS $MAIN_CLASS > $STDOUT 2>&1 &

COUNT=0
while [ $COUNT -lt 1 ]; do    
    echo -e ".\c"
    sleep 1 
    COUNT=`ps -ef | grep java | grep "$DEPLOY_DIR" | awk '{print $2}' | wc -l`
    if [ $COUNT -gt 0 ]; then
        break
    fi
done

echo "OK!"
PIDS=`ps -ef | grep java | grep "$DEPLOY_DIR" | awk '{print $2}'`
echo "PID: $PIDS"
echo "STDOUT: $STDOUT"
