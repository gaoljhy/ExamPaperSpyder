# hadoop2

FROM ubuntu:latest

# ubuntu upper 18.04 bionic

MAINTAINER lemon<gjlove666@hotmail.com>

# 时区设置
ENV TZ=Asia/Shanghai

USER root

RUN echo root:ubuntu | chpasswd -m
# 更新apt 国内源
COPY /shell/apt.sh ~
RUN cd ~
RUN chmod 770 apt.sh
RUN source apt.sh
RUN updateApt



# 安装配置ssh 本地免密登录
EXPOSE 22
COPY /shell/ssh.sh ~
RUN cd ~
RUN chmod 770 ssh.sh
RUN source ssh.sh
RUN sshInstall
RUN sshLogin root localhost ubuntu
RUN sshRsa

# 进入root目录
COPY /shell/jdk_hadoop.sh ~
RUN cd ~
RUN chmod 770 jdk_hadoop.sh
RUN source jdk_hadoop.sh
RUN jdkInstall
RUN adoopInstall()
RUN hadoopConfig()
RUN hdfs namenode -format


# build指令
# docker build -t adminhub/hadoop-local:latest -f hadoop.dockerfile  ./

# 创建指令
# docker create -it --name python-ss -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/python-ssh:latest /bin/bash
# 自启动 ssh
# docker create -it --name python-ssd -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/python-ssh:latest /usr/sbin/sshd -D
# 自启动 all.sh 
# docker create -it --name python-ssd -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/python-ssh:latest /all.sh