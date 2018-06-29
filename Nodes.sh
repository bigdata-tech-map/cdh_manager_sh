#!/bin/bash

# NameNodes
NN_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
)

# DataNodes
DN_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
    "lu-worker-3"
)

# JournalNodes
JN_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
    "lu-worker-3"
)

# ZooKeepers
ZK_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
    "lu-worker-3"
)


declare -A CDH_Services
CDH_Services=(
    [nns]="hadoop-hdfs-namenode"
    [dns]="hadoop-hdfs-datanode"
    [jns]="hadoop-hdfs-journalnode"
    [zks]="zookeeper-server"
)

getNodesOfService(){
case $1 in
        nns)  service_nodes=${NN_Nodes[@]} ;;
        dns)  service_nodes=${DN_Nodes[@]} ;;
        jns)  service_nodes=${JN_Nodes[@]} ;;
        zks)  service_nodes=${ZK_Nodes[@]} ;;
        *)      echo -e "Error, not exist nodes of "$1"\n" && exit ;;
esac
}