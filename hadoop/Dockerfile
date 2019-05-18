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
RUN /bin/bash apt.sh



# 安装配置ssh 本地免密登录
EXPOSE 22

RUN /bin/bash ssh.sh


# 配置环境
RUN /bin/bash jdk_hadoop.sh
RUN hdfs namenode -format


# build指令
# docker build  -t adminhub/hadoop-local:latest -f hadoop.dockerfile  ./

# 创建指令
# docker create -it --name python-ss -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/python-ssh:latest /bin/bash
# 自启动 ssh
# docker create -it --name python-ssd -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/python-ssh:latest /usr/sbin/sshd -D
# 自启动 all.sh 
# docker create -it --name python-ssd -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/python-ssh:latest /all.sh