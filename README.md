# sshd-web
基于Sealos的内网穿透应用

## 所遇到的问题
近日，身为大学生的我，由于参加一个竞赛，需要本地GPU的支持，但是网上GPU租用太贵了，所以突发奇想，试试在Sealos中能否完成内网穿透
经过2小时的奋战，终于给他整出来了


在Sealos应用商店上部署完成后，在本地执行如下脚本，将yourPort改为22端口映射出的port即可
建议使用xxx.sh 1的命令启动（容器重启后ssh密钥会重置，无法免登录进入）
~~~
#!bin/bash

if [ -n "$1" ]
then
    echo "第一次内网穿透，正在初始化......"
    sudo apt-get install autossh
    ssh-keygen
    ssh-copy-id  -p yourPort root@bja.sealos.run

fi
echo "内网穿透执行中......"
autossh -M 4010 -NR 8080:localhost:8080 root@bja.sealos.run -p yourPort
echo "内网穿透结束......"
~~~
