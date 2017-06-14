#!/bin/bash

./wait-for-it.sh zookeeper:2181 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "      Zookeeper not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

/opt/docker/start-hdfs.sh
/opt/docker/start-yarn.sh


########################################
#	IMPALA
########################################
./wait-for-it.sh hive:10002 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "     HIVE not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

/opt/docker/start-impala.sh
