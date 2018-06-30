#!/bin/bash

# Name Nodes
NN_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
)

# ResourceManager Nodes
RM_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
)

# ZKFC Nodes
ZKFC_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
)

# Data Nodes
DN_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
    "lu-worker-3"
)

# NodeManager Nodes
NM_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
    "lu-worker-3"
)

# Journal Nodes
JN_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
    "lu-worker-3"
)

# JobHistory Nodes
JH_Nodes=(
    "lu-worker-1"
)

# ZooKeeper Nodes
ZK_Nodes=(
    "lu-worker-1"
    "lu-worker-2"
    "lu-worker-3"
)


declare -A CDH_Services
CDH_Services=(
    [nns]="hadoop-hdfs-namenode"
    [rms]="hadoop-yarn-resourcemanager"
    [zkfc]="hadoop-hdfs-zkfc"
    [dns]="hadoop-hdfs-datanode"
    [nms]="hadoop-yarn-nodemanager"
    [jns]="hadoop-hdfs-journalnode"
    [jhs]="hadoop-mapreduce-historyserver"
    [zks]="zookeeper-server"
)

getNodesOfService(){
case $1 in
        nns)  service_nodes=${NN_Nodes[@]} ;;
        rms)  service_nodes=${RM_Nodes[@]} ;;
        zkfc)  service_nodes=${ZKFC_Nodes[@]} ;;
        dns)  service_nodes=${DN_Nodes[@]} ;;
        nms)  service_nodes=${NM_Nodes[@]} ;;
        jns)  service_nodes=${JN_Nodes[@]} ;;
        jhs)  service_nodes=${JH_Nodes[@]} ;;
        zks)  service_nodes=${ZK_Nodes[@]} ;;
        *)      echo -e "Error, not exist nodes of "$1"\n" && exit ;;
esac
}