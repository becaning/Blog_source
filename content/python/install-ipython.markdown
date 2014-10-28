Title: 从源码安装ipython
Date: 2014-05-22 09:39
Tags: ipython 
category: python  

##1、什么是ipython?  
ipython是一款功能增强的Python交互式shell环境，和Python自带的交互式命令行环境差不多，只是多了一些额外功能，如Tab补全等。  
###启动界面   
![启动界面](http://becaning-github-io.qiniudn.com/ipython1.png)
<!--more-->
###Tab自动补全   
输入关键字，如import，输入开头字母就可以Tab补全，  
导入模块也可以自动补全    
当输入一个对象加一个点号，然后Tab补全。  
![Tab自动补全](http://becaning-github-io.qiniudn.com/ipython2.png)
###使用shell命令  
在ipython环境中还可以使用shell命令，如ls,cp等。  
![使用shell命令](http://becaning-github-io.qiniudn.com/ipython3.png)
##2、安装  
ipython的安装方式有很多，最简单的如用pip安装，可以参考[官方文档](http://ipython.org/install.html)。  
由于我经常使用[Cygwin](http://www.cygwin.com/)来模拟Linux环境，在Cygwin中不能使用pip安装(我能力有限，未解决)，所以我使用源码安装，其实源码安装特别简单，下载ipython[源码](https://pypi.python.org/pypi/ipython) 解压到家目录。进入ipython目录。  
```bash
    $ python setup.py install  
```

###就这样，搞定了，在命令行中输入ipython享受吧。
