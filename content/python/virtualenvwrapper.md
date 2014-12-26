Title: 用virtualenvwrapper高效管理Python虚拟环境   
Date: 2014-12-25 20:01   
Tags: virtualenv   
category: python      



一、什么是virtualenvwrapper   
-------------------------
   
   
`virtualenvwrapper`是封装了`virtualenv`的一个壳，它提供了各种命令用于方便管理`virtualenv`.   
      
      
二、使用virtualenvwrapper   
-------------------------

####1.安装virtualenvwrappe   

```bash
pip install virtualenvwrapper
```


####2.使用virtualenvwrapper前的设置   
   
   
安装完成`virtualenvwrapper`之后，`virtualenvwrapper`提供了很多命令，但是这些命令需要我们'激活'它:   
```bash
source /usr/local/bin/virtualenvwrapper.sh
```
或者   
```bash
source /usr/bin/virtualenvwrapper.sh
```
为了不用每次使用时都去'激活'它，我们可以把它加到`~/.bashrc`中   
```bash
echo 'source /usr/bin/virtualenvwrapper.sh'>>~/.bashrc
```

激活之后，我们会发现系统里多了一些命令，比如`lsvirtualenv`,`rmvirtualenv`等等   

先别急，为了让`virtualenvwrapper`为我们统一管理python的虚拟环境和工作目录，我们先定义两个环境变量`WORK_HOME`和`PROJECT_HOME`，由于这两个环境变量会被`virtualenvwrapper.sh`所用到，所以我们在`.bashrc`文件中加入时必须放在`source /usr/bin/virtualenvwrapper.sh`之前   
```bash
#.bashrc

WORK_HOME=~/work     #提前创建这个目录，用来存放我们的项目   
PROJECT_HOME=~/.envs   

source /usr/bin/virtualenvwrapper.sh
```

如此一来，每当我们一开机就可以使用`virtualenvwrapper`了^_^   
   
####3.一系列命令   

* `mkvirtualenv`: 创建虚拟环境，eg:`mkvirtualenv env1`   
* `lsvirtualenv`: 列出已有的虚拟环境   
* `rmvirtualenv`: 删除某个虚拟环境,eg:`rmvirtualenv evn1`   
* `cpvirtualenv`: 复制一个现有的虚拟环境   
   
* `mkproject` : 创建一个项目，使用这个命令来创建一个项目的同时还会为这个项目单独创建一个虚拟环境，eg:`mkproject demo1`   
* `workon`: 切换到某个项目中去工作，也就是激活对应的虚拟环境并进入项目的目录中   
   

####4.Simple Workflow   
`virtualenvwrapper`为我们提供了很多命令和各种强大的功能，但对应刚刚开始使用`virtualenvwrapper`的小白，不需要花太多时间去折腾，先简单用起来，熟练使用之后再深入学习.   
   
简单使用`virtualenvwrapper`只需要两步:   
   
1).创建项目:`mkproject demo`,就可以在这个项目中开始工作了，工作完了之后使用`decativate`即可离开虚拟环境   
2).下次还要回到原来的项目继续工作时使用`workon demo`即可进入项目工作   

