Title: FTP服务
Date: 2014-11-21 17:59
Tags: ftp
category: Linux


1.FTP的基础原理知识  
===================
FTP是一种文件传输协议，C/S架构。
在RedHat系列的发行版中的常用的服务器端是vsftpd，客户端很多，常见的如ftp，lftp等等。

FTP服务的架构和其他常见服务有一个很大的差别在于，ftp会建立两个或者更多个通道，一个用于命令传输，其他的用于数据传输。
由此就有了ftp的两种连接模式：主动模式和被动模式。

* 主动模式:由客户端用一个随机端口发出请求连接到服务器(通常是22号端口)，然后进行命令通信，当需要数据传输时，服务器端会使用20号端口发出请求连接到客户端的命令端口减一的端口，假如客户机使用2000端口发出的命令连接，服务器端则主动连接1999端口。

* 被动模式:命令连接和主动模式相同，都是由客户端连接服务器端21号端口。不同的是，当需要数据传输时，服务器端会启动一个端口，然后由客户端去连接服务器端的这个端口，如果有多个数据传输请求，服务器会打开多个端口供客户端连接。

FTP的用户类型分为三种：

* 本地用户: 本地用户就是操作系统本身的用户，也就是/etc/passwd中的用户。当使用本地用户登录ftp时，默认访问的用户自己的家目录。
* 匿名用户: 匿名用户就是在登录ftp服务是不需要任何用户信息，事实上这个操作对应了服务器上的一个特定用户ftp或者是anonymous。
* 虚拟用户: 即ftp建立独立的用户数据库独立维护，独立验证。 

2.安装FTP服务器端可客户端。
==========================
在CentOS中常用的FTP服务器是vsftpd
```bash
yum install vsftpd
```
查看安装后生成的文件
```bash
/etc/logrotate.d/vsftpd
/etc/pam.d/vsftpd
/etc/rc.d/init.d/vsftpd
/etc/vsftpd
/etc/vsftpd/ftpusers
/etc/vsftpd/user_list
/etc/vsftpd/vsftpd.conf
/etc/vsftpd/vsftpd_conf_migrate.sh
/usr/sbin/vsftpd
/usr/share/doc/vsftpd-2.2.2
/usr/share/doc/vsftpd-2.2.2/AUDIT
/usr/share/doc/vsftpd-2.2.2/BENCHMARKS
/usr/share/doc/vsftpd-2.2.2/BUGS
/usr/share/doc/vsftpd-2.2.2/COPYING
/usr/share/doc/vsftpd-2.2.2/Changelog
/usr/share/doc/vsftpd-2.2.2/EXAMPLE
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE/README
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE/README.configuration
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE/vsftpd.conf
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE/vsftpd.xinetd
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE_NOINETD
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE_NOINETD/README
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE_NOINETD/README.configuration
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/INTERNET_SITE_NOINETD/vsftpd.conf
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/PER_IP_CONFIG
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/PER_IP_CONFIG/README
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/PER_IP_CONFIG/README.configuration
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/PER_IP_CONFIG/hosts.allow
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/README
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_HOSTS
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_HOSTS/README
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_USERS
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_USERS/README
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_USERS/README.configuration
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_USERS/logins.txt
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_USERS/vsftpd.conf
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_USERS/vsftpd.pam
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_USERS_2
/usr/share/doc/vsftpd-2.2.2/EXAMPLE/VIRTUAL_USERS_2/README
/usr/share/doc/vsftpd-2.2.2/FAQ
/usr/share/doc/vsftpd-2.2.2/INSTALL
/usr/share/doc/vsftpd-2.2.2/LICENSE
/usr/share/doc/vsftpd-2.2.2/README
/usr/share/doc/vsftpd-2.2.2/README.security
/usr/share/doc/vsftpd-2.2.2/REWARD
/usr/share/doc/vsftpd-2.2.2/SECURITY
/usr/share/doc/vsftpd-2.2.2/SECURITY/DESIGN
/usr/share/doc/vsftpd-2.2.2/SECURITY/IMPLEMENTATION
/usr/share/doc/vsftpd-2.2.2/SECURITY/OVERVIEW
/usr/share/doc/vsftpd-2.2.2/SECURITY/TRUST
/usr/share/doc/vsftpd-2.2.2/SIZE
/usr/share/doc/vsftpd-2.2.2/SPEED
/usr/share/doc/vsftpd-2.2.2/TODO
/usr/share/doc/vsftpd-2.2.2/TUNING
/usr/share/doc/vsftpd-2.2.2/vsftpd.xinetd
/usr/share/man/man5/vsftpd.conf.5.gz
/usr/share/man/man8/vsftpd.8.gz
/var/ftp
/var/ftp/pub
```
其中配置文件在/etc/vsftpd目录下。
/var/ftp目录为匿名用户访问的目录。




