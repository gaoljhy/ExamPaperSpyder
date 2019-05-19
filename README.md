# ExamPaperSpyder

国内考试试卷爬虫

## TODO

1. 实现各年试卷的爬取
2. 写入文本文档及数据库写入
3. Hadoop 单机伪分布 dockerfile
4. 简单词频统计

## 实现流程

1. 选择爬取页面
2. 分析页面组成
3. 得到所需数据来源，并提取链接
4. 对链接进行存取
5. 根据链接进行二层页面爬取
6. 根据爬取内容进行数据清洗
7. 设定re表达式，并测试
8. 获取匹配内容进行进一步处理
9. 建立数据库操作session
10. 进行数据存取，写入
11. 进行文本存取，写入
12. Hadoop分词操作
13. wordcount 词频统计
14. 数据统计分析和可视化

## 欠缺

1. 数据清洗不到位
2. 分词处理速率太慢
3. 爬取网站内容不规范

--------

## hadoop 单机伪分布 配置

### 创建指令

docker create -it --name hadoop -p 2222:22 -v ~/docker-workdir/:/work:rw adminhub/hadoop-local:latest /bin/bash

### 自启动 ssh

docker create -it --name hadoop-ssd -p 2222:22 -v ~/docker-workdir/:/work:rw adminhub/hadoop-local:latest /usr/sbin/sshd -D

### 配置文件集合

```xml
# core
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


# hdfs
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

# mapred
 <configuration>
         <property>
              <name>mapreduce.framework.name</name>
              <value>yarn</value>
         </property>
 </configuration>


# yarn
<configuration>
         <property>
              <name>yarn.nodemanager.aux-services</name>
              <value>mapreduce_shuffle</value>
             </property>
 </configuration>
```