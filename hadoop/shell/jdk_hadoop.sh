#!/bin/bash

# openjdk8 安装及配置
jdkInstall(){
    apt-get -y install openjdk-8-jre openjdk-8-jdk
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /root/.bashrc
} 

# Hadoop安装
hadoopInstall(){
    apt-get -y install wget
    cd ~
    wget https://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.8.4/hadoop-2.8.4.tar.gz
    tar -xvf hadoop-2.8.4.tar.gz
    rm hadoop-2.8.4.tar.gz
    mv hadoop-2.8.4/ /usr/local/hadoop

    echo "
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin" >> /root/.bashrc 
}

core='
 <configuration>
         <property>
              <name>hadoop.tmp.dir</name>
              <value>file:/usr/local/hadoop/tmp</value>
              <description>Abase for other temporary directories.</description>
         </property>
         <property>
              <name>fs.defaultFS</name>
              <value>hdfs://localhost:9000</value>
         </property>
 </configuration>
'

hdfs='
 <configuration>
         <property>
              <name>dfs.replication</name>
              <value>1</value>
         </property>
         <property>
              <name>dfs.namenode.name.dir</name>
              <value>file:/usr/local/hadoop/tmp/dfs/name</value>
         </property>
         <property>
              <name>dfs.datanode.data.dir</name>
              <value>file:/usr/local/hadoop/tmp/dfs/data</value>
         </property>
 </configuration>
'
mapred='
 <configuration>
         <property>
              <name>mapreduce.framework.name</name>
              <value>yarn</value>
         </property>
 </configuration>
'

yarn='
<configuration>
         <property>
              <name>yarn.nodemanager.aux-services</name>
              <value>mapreduce_shuffle</value>
             </property>
 </configuration>
'

localp='$HADOOP_HOME/etc/hadoop/'

hadoopConfig(){
    tac $HADOOP_HOME/etc/hadoop/core-site.xml | sed '1,2d' | tac > $HADOOP_HOME/etc/hadoop/core-site-1.xml
    echo $core >> $HADOOP_HOME/etc/hadoop/core-site-1.xml
    cp $HADOOP_HOME/etc/hadoop/core-site-1.xml $HADOOP_HOME/etc/hadoop/core-site.xml
    
    tac $HADOOP_HOME/etc/hadoop/hdfs-site.xml | sed '1,2d' | tac > $HADOOP_HOME/etc/hadoop/hdfs-site-1.xml
    echo $hdfs >> $HADOOP_HOME/etc/hadoop/hdfs-site-1.xml
    cp $HADOOP_HOME/etc/hadoop/hdfs-site-1.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
    
    tac $HADOOP_HOME/etc/hadoop/mapred-site.xml | sed '1,2d' | tac > $HADOOP_HOME/etc/hadoop/mapred-site-1.xml
    echo $mapred >> $HADOOP_HOME/etc/hadoop/mapred-site-1.xml
    cp $HADOOP_HOME/etc/hadoop/mapred-site-1.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
    
    tac $HADOOP_HOME/etc/hadoop/yarn-site.xml | sed '1,2d' | tac > $HADOOP_HOME/etc/hadoop/yarn-site-1.xml
    echo $yarn >> $HADOOP_HOME/etc/hadoop/yarn-site-1.xml
    cp $HADOOP_HOME/etc/hadoop/yarn-site-1.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
}

jdkInstall
hadoopInstall
hadoopConfig
