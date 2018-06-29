#!/bin/bash

source ./Nodes.sh

service=$1
action=$2

if [ $# -ne 2 ];then
    echo -e "Usage: \n\tsh cdh-manager.sh {service} {start|stop|status|restart} ^_^\n" && exit
fi

echo "params: "$service" "$action

service_name=${CDH_Services[$service]}

if [ -z "$service_name" ];then
    echo -e "Error, not exist service of "$service"\n" && exit
fi

service_nodes=''
getNodesOfService $service

echo "service name: "$service_name
echo "service nodes: "$service_nodes
echo "============================================= begin ============================================================="

start_time=`date +%s`
for slave in $service_nodes
do
        echo "********************************************************************************* running on node: "$slave
        case $action in
                start)  ssh -t root@$slave "service "$service_name" start";;
                stop)   ssh -t root@$slave "service "$service_name" stop" ;;
                status) ssh -t root@$slave "service "$service_name" status" ;;
                restart)ssh -t root@$slave "service "$service_name" restart" ;;
                *)      echo -e "Error, invalid action: "$action && exit ;;
        esac
done
end_time=`date +%s`
elapse_time=$((${end_time}-${start_time}))
echo "=============================================  end  ============================================================="
echo -e "\n$1 service Server takes ${elapse_time} seconds\n"
