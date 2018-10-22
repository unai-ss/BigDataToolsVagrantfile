start-dfs.sh &
PID_HDFS=$!
ps -axf | grep $PID_HDFS
while [ -f /proc/$PID_HDFS ]  do; sleep 1; done
start-yarn.sh &
PID_YARN=$!
ps -axf | grep $PID_YARN
while -f /proc/$PID_YARN do; sleep 1; done
/home/vagrant/hbase-1.2.7/bin/start-hbase.sh start &
PID_HBASE=$!
ps -axf | grep $PID_HBASE
while -f /proc/$PID_HBASE do; sleep 1; done
