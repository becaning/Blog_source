Title: 用virtualenv搭建Python虚拟环境   
Date: 2014-12-22 21:01   
Tags: virtualenv   
category: python   
   
   
一、Python虚拟环境   
==============   
   
我们在用Python开发时，不同的项目可能需要不同的开发环境。比如我们一个项目用的是`Django 1.5`，而另一个项目用的是`Django 1.6`，这个时候就必须要每个项目自己拥有一个独立的环境，为了开发方便，总不能用两台电脑吧，这时怎么办呢，OK，virtualenv可以搞定。   
   
   
二、Virtualenv   
==========   
   
virtualenv是一个纯Python开发的Python环境隔离工具，其工作原理很简单：在你想要的地方建立一个目录，这个目录和系统的Python安装目录类似，目录里有一个完整的Python环境，有解释器，有标准库，也有你自己安装的第三方库。当我们需要使用这个环境时，简单激活即可，所谓激活就是改变系统的`PATH`环境变量，如此一来，我们在运行Python相关的命令或解释器，将会优先到这个目录中寻找，而不是到系统Python环境中去寻找。   
   
   
三、使用virtualenv   
==============   
   
1.安装   
------   
   
```bash   
pip install virtualenv   
   
   
[root@localhost ~]# virtualenv -h   
   
Usage: virtualenv [OPTIONS] DEST_DIR   
   
Options:   
  --version             show program's version number and exit   
  -h, --help            show this help message and exit   
  -v, --verbose         Increase verbosity.   
  -q, --quiet           Decrease verbosity.   
  -p PYTHON_EXE, --python=PYTHON_EXE   
                        The Python interpreter to use, e.g.,   
                        --python=python2.5 will use the python2.5 interpreter   
                        to create the new environment.  The default is the   
                        interpreter that virtualenv was installed with   
                        (/usr/bin/python)   
  --clear               Clear out the non-root install and start from scratch.   
  --no-site-packages    DEPRECATED. Retained only for backward compatibility.   
                        Not having access to global site-packages is now the   
                        default behavior.   
  --system-site-packages   
                        Give the virtual environment access to the global   
                        site-packages.   
  --always-copy         Always copy files rather than symlinking.   
  --unzip-setuptools    Unzip Setuptools when installing it.   
  --relocatable         Make an EXISTING virtualenv environment relocatable.   
                        This fixes up scripts and makes all .pth files   
                        relative.   
  --no-setuptools       Do not install setuptools (or pip) in the new   
                        virtualenv.   
  --no-pip              Do not install pip in the new virtualenv.   
  --extra-search-dir=DIR   
                        Directory to look for setuptools/pip distributions in.   
                        This option can be used multiple times.   
  --never-download      DEPRECATED. Retained only for backward compatibility.   
                        This option has no effect. Virtualenv never downloads   
                        pip or setuptools.   
  --prompt=PROMPT       Provides an alternative prompt prefix for this   
                        environment.   
  --setuptools          DEPRECATED. Retained only for backward compatibility.   
                        This option has no effect.   
  --distribute          DEPRECATED. Retained only for backward compatibility.   
                        This option has no effect.   
   
```   
   
   
   
   
2.使用   
-------   
   
virtualenv <env_name\>   
<env_name\> 是自定义的，随便一个名字，就会在当前目录生成名为`env_name`的目录，也就是新的虚拟环境   
   
```bash   
[root@localhost ~]# virtualenv env1   
[root@localhost ~]# ls   
env1   
   
```   
   
就这样虚拟环境就有了，当我们要使用这个环境时就激活它   
   
```bash   
[root@localhost ~]# source env1/bin/activate   
(env1)[root@localhost ~]#which python   
/root/env1/bin/python   
```   
   
现在就一个激活了，退出这个激活状态使用`deactivate`命令即可   
   
其实`virtualenv`的基本使用也就这样简单的命令，只不过这样使用起来不太方便，一般情况都会使用`virtualenvwrapper`来管理`virtualenv`。   
关于`virtualenvwrapper`的使用请移步[用virtualenvwrapper高效管理Python虚拟环境](/yong-virtualenvwrappergao-xiao-guan-li-pythonxu-ni-huan-jing.html)   
   
   
###附:   
   
   [virtualenv 官方文档](https://virtualenv.readthedocs.org/en/latest/)   
   [virtualenv 中文文档](http://virtualenv-chinese-docs.readthedocs.org/en/latest/)   
