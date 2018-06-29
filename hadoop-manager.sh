#!/bin/bash

# which machine to be active NameNode
NameNode_1=lu-worker-1
# which machine to be standy NameNode
NameNode_2=lu-worker-2
# which machine to be active ResourceManager
ResourceManager_1=lu-worker-1
# which machine to be standby ResourceManager
ResourceManager_2=lu-worker-2
# which machine to be JobHistoryServer
HistoryServer=lu-worker-1


# make sure which namenode is active and which resourcemanager is active
function getServiceState () {

        hdfs haadmin -getServiceState ${NameNode_1} | grep 'active' >> /dev/null && NameNode_Active=${NameNode_1} && NameNode_Standby=${NameNode_2}
        hdfs haadmin -getServiceState ${NameNode_2} | grep 'active' >> /dev/null && NameNode_Active=${NameNode_2} && NameNode_Standby=${NameNode_1}
        yarn rmadmin -getServiceState rm1 | grep 'active' >> /dev/null && ResourceManager_Active=${ResourceManager_1} && ResourceManager_Standby=${ResourceManager_2}
        yarn rmadmin -getServiceState rm2 | grep 'active' >> /dev/null && ResourceManager_Active=${ResourceManager_2} && ResourceManager_Standby=${ResourceManager_1}

}

case $1 in

        start)  ssh -t ${NameNode_1} "/usr/local/cluster/hadoop/sbin/hadoop-daemon.sh start namenode" ;
                ssh -t ${NameNode_1} "/usr/local/cluster/hadoop/sbin/hadoop-daemon.sh start zkfc" ;
                ssh -t ${NameNode_2} "/usr/local/cluster/hadoop/sbin/hadoop-daemon.sh start namenode" ;
                ssh -t ${NameNode_2} "/usr/local/cluster/hadoop/sbin/hadoop-daemon.sh start zkfc" ;
                ssh -t ${NameNode_1} "/usr/local/cluster/hadoop/sbin/hadoop-daemons.sh start datanode" ;
                ssh -t ${ResourceManager_1}     "/usr/local/cluster/hadoop/sbin/start-yarn.sh" ;
                ssh -t ${ResourceManager_2}     "/usr/local/cluster/hadoop/sbin/yarn-daemon.sh start resourcemanager" ;
                ssh -t ${HistoryServer}         "/usr/local/cluster/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver" ;
                ;;

        stop)   getServiceState
                ssh -t ${HistoryServer} "/usr/local/cluster/hadoop/sbin/mr-jobhistory-daemon.sh stop historyserver" ;
                ssh -t ${ResourceManager_Standby} "/usr/local/cluster/hadoop/sbin/yarn-daemon.sh stop resourcemanager" ;
                ssh -t ${ResourceManager_Active} "/usr/local/cluster/hadoop/sbin/stop-yarn.sh" ;
                ssh -t ${NameNode_Active} "/usr/local/cluster/hadoop/sbin/hadoop-daemons.sh stop datanode" ;
                ssh -t ${NameNode_Standby} "/usr/local/cluster/hadoop/sbin/hadoop-daemon.sh stop namenode" ;
                ssh -t ${NameNode_Active} "/usr/local/cluster/hadoop/sbin/hadoop-daemon.sh stop namenode" ;
                ssh -t ${NameNode_Standby} "/usr/local/cluster/hadoop/sbin/hadoop-daemon.sh stop zkfc" ;
                ssh -t ${NameNode_Active} "/usr/local/cluster/hadoop/sbin/hadoop-daemon.sh stop zkfc" ;
                ;;

        * )     echo -e "Usage: hadoop-manager.sh {start|stop} ^_^\n" && exit ;
                ;;
esac

end_time=`date +%s`
elapse_time=$((${end_time}-${start_time}))
echo -e "$1 Hadoop Server takes ${elapse_time} seconds\n"