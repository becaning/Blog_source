Title: 用pelican搭建静态博客
Date: 2014-10-21 08:51
Tags: pelican
category: blog


静态博客？？？
--------------
OK,我们先来说说什么是静态博客，我们常用的博客软件如wordpress是静态博客吗？  
目前常见的网站都是动态网站，何为动态网站，也就是当我们访问一个任意一个页面，其实这个页面事先并不存在，而是在我们访问的那一刻由后端博客软件根据一系列条件生成的html页面返回给我们。  
  
而静态博客就是一个个的html页面，提前生成好了，当我们访问时，由web server直接返回给我们。不需要后台有博客程序做一系列操作。  
  
目前常见的静态博客生成器有[Octopress](http://octopress.org/)，[Pelican](https://github.com/getpelican/pelican)等等。  
  
那么静态博客生成器是如何工作的呢，首先我们用自己喜欢的标记语言（如：markdown）写好文档，然后由博客生成器转换成html页面，这些生产的html页面就是我们博客的内容了，我们可以在任何地方部署它们，甚至是本地直接浏览器打开都没有问题。那么我们常见的部署方式是托管到[Github Pages](https:pages.github.com)。  
  

Getting started with Pelican。
-----------------------

我们现在从头用pelican搭建一个静态博客。  

* pelican是有python编写，所以你需要一个python环境，而且pelican要求2.7以上的版本。  
* 本文是基于Ubuntu系统。只要搭建好python环境，对系统没有什么要求。PS:windows的就自己折腾环境吧，我没在windows上折腾过。  
* pelican文档：[官方文档](http://pelican.readthedocs.org/en/latest/),[中文文档](http://pelican-docs-zh-cn.readthedocs.org/en/latest/)。  



####1.安装  

安装pelican的方式很多，最简单的就是pip了。  
```bash
pip install pelican
```

####2.创建博客  

按照完成之后，在合适的地方创建一个目录，作为你的博客的根据地。  
进入目录后执行<kbd>pelican-quickstart</kbd>命令。之后基本一路按要求回答问题即可。  
```bash
mkdir blog
cd blog
pelican-quickstart
```
这时候博客的基本构成就一个出来了。
```bash
content/ develop_server.sh fabfile.py Makefile output/ pelicanconf.py publishconf.py
```
我们说说几个重要的目录或文件:  

* <code>content/</code>:这是我们存放原始文档(比如我的markdown文件)的目录，可以才里面任意创建目录，在你任意创建的目录中放入你的文档，pelican不会在意是否创建了目录，而是会遍历这个content目录及其之目录。然后强遍历到的文档交给博客生成器转换成html文件。  
* <code>develop_server.sh</code>:这是一个脚本文件，主要用于开启测试服务器。最常用的就是<kbd>./develop_server.sh start</kbd>命令来开启一个测试服务器，每当我们当前目录文件发生改变是，它就会启动博客生成器重新生产html页面。这样就可以达到实时预览了。  
* <code>output/</code>:这个目录里的内容就是博客生成器产物，也就是我们最终需要的东西，这里面保护html页面，还有与主题相关的css,js文件等等。在部署博客时，我们只需要把这个目录的内容部署到web server上就可以了。如果是部署到Github Pages这样的博客托管主机上，那么我们只需在这里创建一个repository，然后push上去就可以了。  
* <code>pelicanconf</code>:这是博客的配置文件，具体配置后面再说。  
* 其它的文件都是和部署相关的，刚开始不需要太关心。  


####3.写博客
这里我们一个markdown文档为例。  
在content目录下创建一个文件，可以随意命名，比如demo.md  
在这个文件中需要写入两部分内容，一是这篇博文的元数据，二是博文的内容。  
元数据可以写很多东西，如文章标题，时间，分类等等。  
博文的内容就是正常的markdown文档。  
如：在demo.md输入以下内容:
```bash
Title: My First Review
Date: 2010-12-03 10:20
Category: Review
My first blog
=============

###subtitle

Following is a review of my favorite mechanical keyboard.
```

写完这个demo.md文档之后，执行一条命令<kbd>pelican content</kbd>，这条命令就是将content下的markdown文件转换成html文件放入output中。此时我们用<kbd>./develop_server.sh start</kbd>命令开启测试服务器就可以在浏览器中访问了。  




###待续。。。





