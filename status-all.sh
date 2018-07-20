#!/bin/bash

source ./Nodes.sh

service_nodes=${ALL_Nodes[@]}

for slave in $service_nodes
do
        echo "********************************************************************************* running on node: "$slave
        ssh -t root@$slave "service --status-all"
done