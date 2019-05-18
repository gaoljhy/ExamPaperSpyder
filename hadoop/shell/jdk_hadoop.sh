#!/bin/bash

# openjdk8 安装及配置
jdkInstall(){
    apt-get -y install openjdk-8-jre openjdk-8-jdk
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /root/.bashrc
} 

# Hadoop安装
hadoopInstall(){
    apt-get -y install wget
    cd /root/shell/
    wget https://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.8.4/hadoop-2.8.4.tar.gz
    tar -xf /root/shell/hadoop-2.8.4.tar.gz 
    rm /root/shell/hadoop-2.8.4.tar.gz
    mv /root/shell/hadoop-2.8.4/ /usr/local/hadoop
    echo '
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export  HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib:$HADOOP_COMMON_LIB_NATIVE_DIR"
' >> /root/.bashrc 

}

core='
<configuration>\n
     <property>\n
              <name>hadoop.tmp.dir</name>\n
              <value>file:/usr/local/hadoop/tmp</value>\n
              <description>Abase for other temporary directories.</description>\n
         </property>\n
         <property>\n
              <name>fs.defaultFS</name>\n
              <value>hdfs://localhost:9000</value>\n
         </property>\n
 </configuration>\n
'

hdfs='
 <configuration>\n
         <property>\n
              <name>dfs.replication</name>\n
              <value>1</value>\n
         </property>\n
         <property>\n
              <name>dfs.namenode.name.dir</name>\n
              <value>file:/usr/local/hadoop/tmp/dfs/name</value>\n
         </property>\n
         <property>\n
              <name>dfs.datanode.data.dir</name>\n
              <value>file:/usr/local/hadoop/tmp/dfs/data</value>\n
         </property>\n
 </configuration>\n
'
mapred='
 <configuration>\n
         <property>\n
              <name>mapreduce.framework.name</name>\n
              <value>yarn</value>\n
         </property>\n
 </configuration>\n
'

yarn='
<configuration>\n
         <property>\n
              <name>yarn.nodemanager.aux-services</name>\n
              <value>mapreduce_shuffle</value>\n
             </property>\n
 </configuration>\n
'

localp='/usr/local/hadoop/etc/hadoop/'

hadoopConfig(){
    tac $localp/core-site.xml | sed '1,2d' | tac > $localp/core-site-1.xml
    echo -e $core >> $localp/core-site-1.xml
    cp $localp/core-site-1.xml $localp/core-site.xml
    
    tac $localp/hdfs-site.xml | sed '1,3d' | tac > $localp/hdfs-site-1.xml
    echo -e $hdfs >> $localp/hdfs-site-1.xml
    cp $localp/hdfs-site-1.xml $localp/hdfs-site.xml
    
    tac $localp/mapred-site.xml.template | sed '1,3d' | tac > $localp/mapred-site-1.xml
    echo -e $mapred >> $localp/mapred-site-1.xml
    cp $localp/mapred-site-1.xml $localp/mapred-site.xml
    
    tac $localp/yarn-site.xml | sed '1,5d' | tac > $localp/yarn-site-1.xml
    echo -e $yarn >> $localp/yarn-site-1.xml
    cp $localp/yarn-site-1.xml $localp/yarn-site.xml
    echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> $localp/hadoop-env.sh
    
}

jdkInstall
hadoopInstall
source /root/.bashrc
hadoopConfig
