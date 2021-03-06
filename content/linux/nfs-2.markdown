Title: 一步步搭建NFS服务（2）------安装和配置  
Date: 2014-04-12 06:14
Tags: nfs
category: Linux  
  
###一、需要安装的软件包  
  
1）rpcbind :RPC的主程序，这个软件包在客户端和服务器端都需要安装  
2）nfs-utils :NFS的主程序，提供nfsd和mountd等相关服务，客户端和服务端都要安装  
###二、开始行动。。。  
<!--more-->  
为了便于区分客户端和服务端，我分别将主机名改为Server和Client  
```bash  
[root@Server ~]# hostname  
Server  
[root@Server ~]#  
```  
```bash  
[root@Client ~]# hostname  
Client  
[root@Client ~]#  
```  
1）两台主机分别安装rpcbind和nfs-utils  
```bash  
[root@Server ~]# yum install rpcbind  
#此处省略若干行#  
Dependencies Resolved  
=======================================================================================================  
 Package                 Arch                Version                     Repository               Size  
=======================================================================================================  
Installing:  
 rpcbind                 x86_64              0.2.0-11.el6                local_repo               51 k  
Installing for dependencies:  
 libgssglue              x86_64              0.1-11.el6                  local_repo               23 k  
 libtirpc                x86_64              0.2.1-6.el6_4               local_repo               78 k  
   
Transaction Summary  
=======================================================================================================  
Install       3 Package(s)  
#此处省略若干行#  
Installed:  
  rpcbind.x86_64 0:0.2.0-11.el6                                                                         
   
Dependency Installed:  
  libgssglue.x86_64 0:0.1-11.el6                    libtirpc.x86_64 0:0.2.1-6.el6_4                    
   
Complete!  
[root@Server ~]#  
```  
```bash  
[root@Server ~]# yum install nfs-utils  
   
####此处省略若干行  
   
=======================================================================================================  
 Package                   Arch               Version                     Repository              Size  
=======================================================================================================  
Installing:  
 nfs-utils                 x86_64             1:1.2.3-39.el6              local_repo             320 k  
Installing for dependencies:  
 keyutils                  x86_64             1.4-4.el6                   local_repo              39 k  
 libevent                  x86_64             1.4.13-4.el6                local_repo              66 k  
 nfs-utils-lib             x86_64             1.1.5-6.el6                 local_repo              67 k  
    
Transaction Summary  
=======================================================================================================  
Install       4 Package(s)  
   
####此处省略若干行  
   
Installed:  
   
  nfs-utils.x86_64 1:1.2.3-39.el6                                                                      
    
Dependency Installed:  
  keyutils.x86_64 0:1.4-4.el6   libevent.x86_64 0:1.4.13-4.el6   nfs-utils-lib.x86_64 0:1.1.5-6.el6  
    
Complete!  
[root@Server ~]#  
```  
3)分析一下安装之后生成的文件  
  
先看看rpcbind的  
```bash  
[root@Client ~]# rpm -ql rpcbind  
/etc/rc.d/init.d/rpcbind           #红帽系的启动脚本  
/sbin/rpcbind                      #rpcbind的启动和管理命令  
/usr/sbin/rpcinfo                  #查询指定主机的rpc信息  
####下面都是打酱油的  
/usr/share/doc/rpcbind-0.2.0  
/usr/share/doc/rpcbind-0.2.0/AUTHORS  
/usr/share/doc/rpcbind-0.2.0/ChangeLog  
/usr/share/doc/rpcbind-0.2.0/README  
/usr/share/man/man8/rpcbind.8.gz  
/usr/share/man/man8/rpcinfo.8.gz  
/var/cache/rpcbind  
[root@Client ~]#  
```  
在看看nfs-utils的  
```bash  
[root@Server ~]# rpm -ql nfs-utils  
/etc/nfsmount.conf  
/etc/rc.d/init.d/nfs  
/etc/rc.d/init.d/nfslock  
/etc/rc.d/init.d/rpcgssd  
/etc/rc.d/init.d/rpcidmapd  
/etc/rc.d/init.d/rpcsvcgssd  
/etc/request-key.d/id_resolver.conf  
/etc/sysconfig/nfs  
/sbin/mount.nfs  
/sbin/mount.nfs4  
/sbin/nfs_cache_getent  
/sbin/rpc.statd  
/sbin/umount.nfs  
/sbin/umount.nfs4  
/usr/sbin/exportfs  
/usr/sbin/mountstats  
/usr/sbin/nfsidmap  
/usr/sbin/nfsiostat  
/usr/sbin/nfsstat  
/usr/sbin/rpc.gssd  
/usr/sbin/rpc.idmapd  
/usr/sbin/rpc.mountd  
/usr/sbin/rpc.nfsd  
/usr/sbin/rpc.svcgssd  
/usr/sbin/rpcdebug  
/usr/sbin/showmount  
/usr/sbin/sm-notify  
/usr/sbin/start-statd  
###下面若干行省略  
```  
注意：有一个特特特别重要的文件上面没有列出来，那就是/etc/exports这个文件，这是这是用于配置nfs共享文件的配置，十分重要，后面详细介绍。  
  
4）启动RPC服务和NFS服务  
  
在启动NFS服务之前一定先启动RPC服务，so，启动rpcbind,然后用rpcinfo探测本机rpc信息。  
  
```bash  
[root@Client ~]# service rpcbind start  
Starting rpcbind:                                          [  OK  ]  
[root@Client ~]# rpcinfo 127.0.0.1  
   program version netid     address                service    owner  
    100000    4    tcp6      ::.0.111               portmapper superuser  
    100000    3    tcp6      ::.0.111               portmapper superuser  
    100000    4    udp6      ::.0.111               portmapper superuser  
    100000    3    udp6      ::.0.111               portmapper superuser  
    100000    4    tcp       0.0.0.0.0.111          portmapper superuser  
    100000    3    tcp       0.0.0.0.0.111          portmapper superuser  
    100000    2    tcp       0.0.0.0.0.111          portmapper superuser  
    100000    4    udp       0.0.0.0.0.111          portmapper superuser  
    100000    3    udp       0.0.0.0.0.111          portmapper superuser  
    100000    2    udp       0.0.0.0.0.111          portmapper superuser  
    100000    4    local     /var/run/rpcbind.sock  portmapper superuser  
    100000    3    local     /var/run/rpcbind.sock  portmapper superuser  
[root@Client ~]#  
```  
从上面对rpcinfo中没有发现任何和NFS有关的信息，那是因为我们探测的是Client端。  
  
好，那我们把服务端的rpcbind和NFS启动  
```bash  
[root@Server ~]# service rpcbind start  
Starting rpcbind:                                          [  OK  ]  
[root@Server ~]# service nfs start  
Starting NFS services:                                     [  OK  ]  
Starting NFS quotas:                                       [  OK  ]  
Starting NFS mountd:                                       [  OK  ]  
Starting NFS daemon:                                       [  OK  ]  
Starting RPC idmapd:                                       [  OK  ]  
[root@Server ~]#  
```  
可以看出来，当起动nfs主服务，随之一起启动的还有quotas(配额服务)，mountd(挂载和访问权限控制的)等等。  
  
现在我们在回过头来在客户端用rpcinfo探测服务端。  
  
```bash  
[root@Client ~]# rpcinfo 192.168.80.102  
   program version netid     address                service    owner  
    100000    4    tcp6      ::.0.111               portmapper superuser  
    100000    3    tcp6      ::.0.111               portmapper superuser  
    100000    4    udp6      ::.0.111               portmapper superuser  
    100000    3    udp6      ::.0.111               portmapper superuser  
    100000    4    tcp       0.0.0.0.0.111          portmapper superuser  
    100000    3    tcp       0.0.0.0.0.111          portmapper superuser  
    100000    2    tcp       0.0.0.0.0.111          portmapper superuser  
    100000    4    udp       0.0.0.0.0.111          portmapper superuser  
    100000    3    udp       0.0.0.0.0.111          portmapper superuser  
    100000    2    udp       0.0.0.0.0.111          portmapper superuser  
    100000    4    local     /var/run/rpcbind.sock  portmapper superuser  
    100000    3    local     /var/run/rpcbind.sock  portmapper superuser  
    100011    1    udp       0.0.0.0.3.107          rquotad    superuser  
    100011    2    udp       0.0.0.0.3.107          rquotad    superuser  
    100011    1    tcp       0.0.0.0.3.107          rquotad    superuser  
    100011    2    tcp       0.0.0.0.3.107          rquotad    superuser  
    100005    1    udp       0.0.0.0.170.4          mountd     superuser  
    100005    1    tcp       0.0.0.0.233.174        mountd     superuser  
    100005    1    udp6      ::.179.140             mountd     superuser  
    100005    1    tcp6      ::.163.49              mountd     superuser  
    100005    2    udp       0.0.0.0.166.4          mountd     superuser  
    100005    2    tcp       0.0.0.0.201.171        mountd     superuser  
    100005    2    udp6      ::.229.140             mountd     superuser  
    100005    2    tcp6      ::.229.7               mountd     superuser  
    100005    3    udp       0.0.0.0.237.110        mountd     superuser  
    100005    3    tcp       0.0.0.0.183.5          mountd     superuser  
    100005    3    udp6      ::.157.246             mountd     superuser  
    100005    3    tcp6      ::.216.13              mountd     superuser  
    100003    2    tcp       0.0.0.0.8.1            nfs        superuser  
    100003    3    tcp       0.0.0.0.8.1            nfs        superuser  
    100003    4    tcp       0.0.0.0.8.1            nfs        superuser  
    100227    2    tcp       0.0.0.0.8.1            nfs_acl    superuser  
    100227    3    tcp       0.0.0.0.8.1            nfs_acl    superuser  
    100003    2    udp       0.0.0.0.8.1            nfs        superuser  
    100003    3    udp       0.0.0.0.8.1            nfs        superuser  
    100003    4    udp       0.0.0.0.8.1            nfs        superuser  
    100227    2    udp       0.0.0.0.8.1            nfs_acl    superuser  
    100227    3    udp       0.0.0.0.8.1            nfs_acl    superuser  
    100003    2    tcp6      ::.8.1                 nfs        superuser  
    100003    3    tcp6      ::.8.1                 nfs        superuser  
    100003    4    tcp6      ::.8.1                 nfs        superuser  
    100227    2    tcp6      ::.8.1                 nfs_acl    superuser  
    100227    3    tcp6      ::.8.1                 nfs_acl    superuser  
    100003    2    udp6      ::.8.1                 nfs        superuser  
    100003    3    udp6      ::.8.1                 nfs        superuser  
    100003    4    udp6      ::.8.1                 nfs        superuser  
    100227    2    udp6      ::.8.1                 nfs_acl    superuser  
    100227    3    udp6      ::.8.1                 nfs_acl    superuser  
    100021    1    udp       0.0.0.0.231.70         nlockmgr   superuser  
    100021    3    udp       0.0.0.0.231.70         nlockmgr   superuser  
    100021    4    udp       0.0.0.0.231.70         nlockmgr   superuser  
    100021    1    tcp       0.0.0.0.167.220        nlockmgr   superuser  
    100021    3    tcp       0.0.0.0.167.220        nlockmgr   superuser  
    100021    4    tcp       0.0.0.0.167.220        nlockmgr   superuser  
    100021    1    udp6      ::.190.58              nlockmgr   superuser  
    100021    3    udp6      ::.190.58              nlockmgr   superuser  
    100021    4    udp6      ::.190.58              nlockmgr   superuser  
    100021    1    tcp6      ::.160.232             nlockmgr   superuser  
    100021    3    tcp6      ::.160.232             nlockmgr   superuser  
    100021    4    tcp6      ::.160.232             nlockmgr   superuser  
[root@Client ~]#  
```  
再看看是不是就多了很多信息啦，现在服务端的rpc就多了nfs相关的子服务了。  
  
###三、配置和使用  
  
双方的服务都搭建好了，现在就是使用吧  
  
1）配置服务端要共享出去的目录或者分区，这个配置就是刚刚说到的/etc/exports文件了  
  
/etc/exports配置规则：[共享目录] \[客户端][权限]  
  
\[共享文件]:这个随意，如 /home/works/  
  
\[客户端]: 分享给谁，谁可以访问，这里可以使用主机ip、网络号ip还有主机名  
  
主机ip:如192.168.80.101/24  
  
网络号：如 192.168.80.0/24  
  
主机名：如www.baidu.com,如果用主机名配置，可以使用通配符。如 \*.baidu.com就表示任何baidu.com的三级域名都可以访问  
  
[权限] 需要注意的是，上面的每一项都是空格分开，但是权限要紧随\[客户端]后面，用括号括起来  
  
具体的权限选项：  
**rw**: 读写  
**ro**: 只读   
**secure**: 默认已经启用；限制客户端只能使用小于1024的端口访问请求；若不加限制，则使用insecure  
**async**: 异步写入，性能好，数据可靠性差；  
**sync**: 同步写入，性能差，数据可靠性高；  
**wdelay**: 写入延迟；no_wdelay  
**nohide**: 不隐藏要导出的目录中挂载的其它nfs；  
**no_acl**: 关闭nfs的acl功能；  
**root_squash**: 压缩root权限, nfsnobody  
**no_root_squash**: 不压缩root权限  
**all_squash**：所有用户都压缩  
anonuid=nfsuser,anongid=nfsgroup：使用指定的用户帐号做匿名用户帐号  
现在我们就配置一下我们客户端可以访问的nfs服务  
  
```bash  
/data/ 192.168.80.0/24(rw)  
```  
配置好exports文件后，重启nfs服务  
  
重启完成之后我们在客户端用showmount命令检查一下服务端共享的文件  
```bash  
[root@Client ~]# showmount -e 192.168.80.102  
Export list for 192.168.80.102:  
/data 192.168.80.0/24  
[root@Client ~]#  
```  
可以看到服务端共享了/data这个目录，那我们赶紧挂载使用吧。  
  
将对方的/data/挂载到本地/nfstest/里  
```bash  
[root@Client ~]# mount 192.168.80.102:/data /nfstest  
[root@Client ~]# ls /nfstest/  
fstab  inittab  
[root@Client ~]#  
```  
ok,挂载成功，可以使用了，但是真的可以使用了吗，还不一定，why?权限问题，NFS服务中，权限是个大问题，也是NFS服务中最头痛的问题，额。。。。请听下回分解。。。  
  
