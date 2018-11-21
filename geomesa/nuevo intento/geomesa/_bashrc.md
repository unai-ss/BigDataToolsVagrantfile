```
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export HADOOP_INSTALL=/home/vagrant/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
export HADOOP_HOME=$HADOOP_INSTALL
export GEOMESA_HBASE_HOME=/home/vagrant/geomesa
export HBASE_HOME=/home/vagrant/hbase
export PATH=$PATH:$HBASE_HOME/bin:/home/vagrant/maven/bin:$GEOMESA_HBASE_HOME/bin
#export HBASE_REGIONSERVERS=${HBASE_HOME}/conf/regionservers
export HBASE_MANAGES_ZK=true
export HBASE_DISABLE_HADOOP_CLASSPATH_LOOKUP=true
```
