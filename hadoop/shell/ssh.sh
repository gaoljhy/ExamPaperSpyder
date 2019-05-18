#!/bin/bash

# ssh 安装及开启服务
sshInstall(){
    apt-get -y install expect
    apt-get -y install openssh-server
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
    service ssh restart
}

# ssh keygen 生成本地 rsa
sshRsa(){
    /usr/bin/expect << INP
    spawn ssh-keygen -t rsa 
    expect {
        "file" { send "\n";exp_continue }
        "empty" { send "\n";exp_continue }
        "again" { send "\n" }
    }
    interact
    expect eof
INP
    cd ~/.ssh
    cat ./id_rsa.pub >> ./authorized_keys
}

# ssh 登录
# sshLogin user host password
sshLogin(){
    /usr/bin/expect << INP
    set timeout 2
    spawn ssh ${1}@${2}
    expect {
        "Cannot assign requested address" { exit }
        "yes/no" { send "yes\r";exp_continue }
        "password" { send "${3}\r" }
    }
    interact
INP
}

sshInstall
sshLogin root localhost ubuntu
sshRsa