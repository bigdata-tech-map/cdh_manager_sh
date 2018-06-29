#!/bin/bash

source Nodes.sh
SLAVES=$JN_Nodes

start_time=`date +%s`
for slave in ${SLAVES[@]}
do
        case $1 in
                start)  ssh -t $slave "service hadoop-hdfs-journalnode start" 1>/dev/null;;
                stop)   ssh -t $slave "service hadoop-hdfs-journalnode stop" 1>/dev/null ;;
                status) ssh -t $slave "service hadoop-hdfs-journalnode status" ;;
                restart)ssh -t $slave "service hadoop-hdfs-journalnode restart" 1>/dev/null;;
                *)      echo -e "Usage: sh journal-manager.sh {start|stop|restart} ^_^\n" && exit ;;
        esac
done
end_time=`date +%s`
elapse_time=$((${end_time}-${start_time}))
echo -e "\n$1 JournalNode Server takes ${elapse_time} seconds\n"