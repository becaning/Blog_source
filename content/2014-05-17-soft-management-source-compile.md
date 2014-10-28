Title: Linux软件包管理之源码编译安装
Date: 2014-05-17 12:01
Tags: soft-management
category: Linux

环境  
<code>
* OS:CentOS 6.5 64位  
* 示例软件:nginx   
</code>

从源代码出发
============

在Linux环境中，大多数的软件都是用c/c++开发的，这两种语言开发的软件编译安装没有任何区别，我们现在先来看看一款Linux环境中的软件源码组成结构。
```bash
[root@Server nginx-1.6.1]# ls
auto  CHANGES  CHANGES.ru  conf  configure  contrib  html  LICENSE  man  README  src
```
在我们解压每一个软件包后，进入软件包目录，第一件事都应该阅读以下README和INSTSLL文件，这是一个好的习惯。
从源码包里众多源文件来看，我们就会发现一个问题，我们自己学c语言时，写的小程序都是一个源文件，但是这里有多个，而且这多个源文件是有相互依赖关系的，这就导致我们不可能用gcc一个个的编译。这就引出了和软件包编译相关的make等一系列工具。
为了说明这一系列工具，我们先从configure倒着说回来，我们刚刚说到源码包中包含了很多个源文件，这些源文件是存在一定的相互依赖关系，这个关系是有谁来维持呢，那就是Makefile文件，在Makefile文件中定义了这些源文件的编译关系,用于指导make命令工作。那么这个Makefile文件时从哪儿来的呢，这是一个文本文件，可以自己手写，但是一方面我们不一定有这个能力，另一方面手写Makefile是一个没有意义的事，因为Makefile是可以自动生成的。
我们再来看看Makefile文件是如何自动生成的，自动生成Makefile文件需要两个文件，分别是configure和Makefile.in，继续追溯这个问题，configure文件和Makefile.in文件又从哪儿来的呢，configure文件是由autoconf命令自动生成的，Makefile.in是由automake命令自动生成的。
我们来梳理一下关系
```bash
  autoconf命令 ---->configure文件     Makefile.in文件 <---- automake命令       
                      |                     |        
                      |                     |   
                      -----------------------
                                ||
                                \/
  sourse code ----> make命令 + makefile文件 ----->可执行文件
```
通过梳理关系我们可以看到，一切的工作都是为了生成Makefile文件，而软件包中提供了configure文件，这是为什么呢，为什么不直接提供Makefile文件呢。原因很简单，每个人在编译软件是都有一些自己个性化的设置，这些设置就要在configure这一步来做，然后configure文件根据给定的设置以及系统平台特性来生成Makefile文件。

开始动手啦
==========
弄明白上面的理论知识，下面动手操作的东西就很简单了，一般来说源码编译安装软件分三步：

* ./configure:这一步其实是可以指定很多选项的，也就是个性化设置，可以使用<kbd>./configure --help</kbd>来查看可以使用的选项，最常见的就是<kbd>--prefix=PATH</kbd>指定安装路径。
* make:这一步无需使用任何选项，只要上一步顺利执行，这一步一般也不会有什么意外，一切都是自动执行，默默等待吧。
* make install:这一步本质上就是把上一步编译出来的结果复制到我们指定的目录而已。

####Example:
```bash
[root@Server nginx-1.6.1]# ./configure --prefix=/usr/local/nginx
checking for OS
+ Linux 2.6.32-431.el6.x86_64 x86_64
checking for C compiler ... found
+ using GNU C compiler
+ gcc version: 4.4.7 20120313 (Red Hat 4.4.7-4) (GCC) 
checking for gcc -pipe switch ... found
checking for gcc builtin atomic operations ... found
checking for C99 variadic macros ... found

#此处省略若干行，都是在做checking

checking for zlib library ... found
creating objs/Makefile

Configuration summary
+ using system PCRE library
+ OpenSSL library is not used
+ md5: using system crypto library
+ sha1: using system crypto library
+ using system zlib library

nginx path prefix: "/usr/local/nginx"
nginx binary file: "/usr/local/nginx/sbin/nginx"
nginx configuration prefix: "/usr/local/nginx/conf"
nginx configuration file: "/usr/local/nginx/conf/nginx.conf"
ginx pid file: "/usr/local/nginx/logs/nginx.pid"
nginx error log file: "/usr/local/nginx/logs/error.log"
nginx http access log file: "/usr/local/nginx/logs/access.log"
nginx http client request body temporary files: "client_body_temp"
nginx http proxy temporary files: "proxy_temp"
nginx http fastcgi temporary files: "fastcgi_temp"
nginx http uwsgi temporary files: "uwsgi_temp"
nginx http scgi temporary files: "scgi_temp"
```
到此处，./configure文件就完成了环境检查，选项设置，此刻我们的源码包中多了一个Makefile文件，下一步就是指向make命令。
```bash
[root@Server nginx-1.6.1]# make

#出现一堆乱七八糟的输出结果
[root@Server nginx-1.6.1]# make install

#各种创建目录，复制文件。
```
到此，软件编译安装就结束了


处理后事
=======

软件包编译安装结束之后还有很多工作需要做的

* 添加PATH路径:默认的PATH路径中是找不到我们安装的可执行文件的，所以我们要手动添加。
* 添加man文档搜索路径:这个我们可以修改man的配置文件。
* 添加库文件和头文件的搜索路径:以Apache服务器为例，安装完成之后会生成很多库文件，这些库文件在别的程序中有可能是被依赖的，常见的做法就是做一个链接到lib目录下去。




