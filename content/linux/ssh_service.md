Title: ssh service
Date: 2014-10-24 22:54
Tags: ssh
category: linux



##细说ssh服务  
===========


一、ssh服务概述
===============
ssh(Secure Shell),安全加密远程主机登录协议，加密传输数据。

二、OpenSSH的解决方案
=====================
OpenSSH是一套ssh的开源解决方案，同时提供了服务器端和客户端。
服务器端软件包名:opensshd
客户端软件包名:openssh
```bash
yum install openssh-server
```
安装完软件之后，所以配置文件都在/etc/ssh目录下
```bash
ls /etc/ssh
moduli  ssh_config  sshd_config  ssh_host_dsa_key  ssh_host_dsa_key.pub  ssh_host_key  ssh_host_key.pub  ssh_host_rsa_key  ssh_host_rsa_key.pub
```
其中：
ssh_config是客户端的配置文件
sshd_config是服务器端的配置文件
后面的三个key结尾的是三种不同加密方式生成的主机私钥，三个 <code>key.pub</code>结尾的文件是分别对应的公钥

在每个用户的家目录下还有一个 <code>.ssh/</code>的隐藏目录
```bash
ls ~/.ssh/
authorized_keys  id_rsa  id_rsa.pub  known_hosts
```
其中:
authorized_keys是用于保存远程主机公钥，用于远程主机登录本主机时基于密钥登录认证
id_rsa本用户的主机私钥
id_rsa.pub本用户的主机公钥
known_hosts记录远程登录过的客户端

PS:也许你的家目录下没有 <code>.ssh/</code>目录，或者没有该目录下的某个文件


三、OpenSSH服务器端管理
=======================

四、ssh客户端管理
=================

五、ssh服务最佳实践
===================

