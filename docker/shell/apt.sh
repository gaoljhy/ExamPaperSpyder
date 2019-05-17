#!/bin/bash

# ubuntu 18.04 upper bionic
updateApt(){
    mv /etc/apt/sources.list /etc/apt/sources.list.back

    cat > /etc/apt/sources.list <<EOF
    deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse 
    deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse 
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse 
    deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse 
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse 
    deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse 
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse 
    deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse 
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse 
EOF

    apt-get update

}
