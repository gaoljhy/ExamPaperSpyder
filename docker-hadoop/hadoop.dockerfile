# hadoop2

FROM ubuntu:latest

# ubuntu upper 18.04 bionic

MAINTAINER lemon<gjlove666@hotmail.com>

# 时区设置
ENV TZ=Asia/Shanghai

USER root

RUN echo root:ubuntu | chpasswd -m

COPY shell/  /root/shell/
RUN chmod -R 777 ~/shell/

WORKDIR /root/shell/

# 更新apt 国内源
# 安装配置ssh 本地免密登录
# 配置环境
EXPOSE 22
RUN /bin/bash apt.sh
RUN apt-get update && apt-get --fix-missing -y install openssh-server expect openjdk-8-jre openjdk-8-jdk
RUN /bin/bash ssh.sh && /bin/bash jdk_hadoop.sh

RUN service ssh start




# service  ~/.bashrc
# hdfs namenode -format

# build指令
# docker build  -t adminhub/hadoop-local:latest -f hadoop.dockerfile  ./

# 创建指令
# docker create -it --name hadoop -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/hadoop-local:latest /bin/bash
# 自启动 ssh
# docker create -it --name hadoop -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/hadoop-local:latest /usr/sbin/sshd -D
# 自启动 all.sh 
# docker create -it --name hadoop -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/hadoop-local:latest /all.sh