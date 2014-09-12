Title: 文件日常操作  
Date: 2014-04-16 01:18
Tags: linux 
category: blog

###一、linux的文件的分类  
文件类型:  表示符号  
普通文件:              -  
目录:                  d(directory)  
符号链接/软链接:       l(link)  
块设备:                b(block)  
管道:                  p(pipe)  
套接字:                s(socket)  
###二、创建文件和目录  
创建文件的方法很多，但是思想是差不多的。  
**1**、用文件编辑器创建：编辑器 + 文件名，如果文件名已经存在则直接打开，如果不存在就创建自豪打开。  
比如vim 123.php  
**2**、用touch命令创建，touch命令的本意是‘触摸’一下文件，使其时间戳改变，但是如果要‘触摸’的不存在则创建该文件  
**3**、目录其实也是文件，创建目录用mkdir命令，如:mkdir testdir，但是如果要创建一个目录的父目录没有的话，是不会成功的，必须加上一个选项**-p**,比如：mkdir -p /a/b/c/d，这样就看成功创建了
<!--more-->
###三、查看文件内容  
**1**、cat和tac:  
cat查看整个文件，将文件内容从头到尾全部打印在屏幕，如果文件很长就只能看见后面的。  
tac和cat类似，将文件从未到头打印，其他与cat完全相同  
**2**、less  
这个命令比较好用，less + $filename,将文件内容从头开始打印，刚刚打印一屏。  
当文件打印一屏后就有几个操作：  
向下翻页：j键或者Shift+PageDown  
向上翻页：k键或者Shift+PageUp  
退出查看：q键  
  
搜索关键字  
   :/keyword 从头开始搜索keyword  
   :?keyword 从尾向前搜索keyword  
   搜索出结果之后  
   小n键：朝你搜索的方向调至下一个，比如你说从头向尾搜索，则是从头向尾下一个，反之亦然。  
   大N键：朝你搜索的方向调至上一个，比如你说从头向尾搜索，则是从尾向头下一个，反之亦然。  
**3**、more  
 more与less的功能和操作一样，有一个不同点。如果用less查看文件内容，不管文件内容多与少都不会自动退出文件内容页面，任何时候都可以上下翻页，直至按q键退出。more则不同，如果你已经翻页至文件尾部会自动退出退出而进入命令提示符，就不能往前翻页了。  
**4**、head与tail  
  从英文单词就看出来，一个是看头部，一个是看尾部。  
  这两个命令有一个参数 -n 就是从头或从尾看出几行，如果不指定默认是10行。  
  比如：head -n 5 123.php 就是查看123.php的前5行内容，也可以简写去掉n，就成了head -5 123.php,tail也是一样的。  
  
###四、移动和复制文件  
**1**、文件复制 cp(copy简写)  
这个命令要仔细讨论一下几种情况：  
 **(1)**.当要复制的文件时单个文件时  
   cp /path/to/file /path/to/name  
   当name为一个已经存在的文件时，则会覆盖这个文件  
   当name不存在时，则复制并重命名为name  
   当name为目录是，将会把file复制到name之中  
 **(2)**.当要复制的文件时多个文件时  
   cp /path/to/file ... /path/to/name  
   这种情况下最后的/path/to/name必须为目录，否则报错  
 **(3)**.当要复制的文件为目录时  
   如果之前复制目录，那么cp会略过目录，这是就需要加一个参数 -r或-R(recursive)递归复制，ok搞定  
**2**、移动文件  
  仔细学习了cp,这个移动文件就没什么好讲的了，操作基本一样，一个保留源文件，另一个不保留源文件  
  注意：这里只是介绍了移动和复制文件时的几种常见，命令的详细参数可以man一下，有详细说明  
###五、删除文件  
删除普通文件用rm命令，删除目录用rmdir命令，但是rmdir只能删除空目录，说很少使用，常使用rm，我们先man一下rm命令：  
```bash
  NAME  
         rm - remove files or directories  
  
  SYNOPSIS  
         rm [OPTION]... FILE...  
  
  DESCRIPTION  
         This  manual  page  documents the GNU version of rm.  rm removes each specified file.  
         By default, it does not remove directories.  
  
         If the -I or --interactive=once option is given, and there are more than three  files  
         or the -r, -R, or --recursive are given, then rm prompts the user for whether to pro-  
         ceed with the entire operation.  If the response is not affirmative, the entire  com-  
         mand is aborted.  
  
         Otherwise,  if  a  file  is  unwritable,  standard input is a terminal, and the -f or  
         --force option is not given, or the -i or --interactive=always option  is  given,  rm  
         prompts the user for whether to remove the file.  If the response is not affirmative,  
         the file is skipped.  
```
这个命令操作比较简单  
rm 选项 要删除的文件  
这里要删除的文件可以是单个文件，也可以是多个文件。  
重点说说选项  
删除一个普通文件无需任何参数即可  
rm file  
如果要删除的是目录，则会提醒你这是一个目录，然后不删除，这是需要加一个参数-r或者-R,  
rm -r dirname  
有时候会提示你是否删除，如果你不想看提示而直接删除则加一个参数-f(force)  
rm -rf dirname  
  
###六、技巧提升---bash通配符  
在bash中支持通配符，比如\*表示一个或多个字符  
ls \*.txt 则显示所有已.txt结尾的文件或者目录  
通配符使用方法和场景都差不多，比如复制，移动，删除还有查找等  
这里列出平时常用的通配符  
\*：任意长度的任意字符；  
?: 任意单个字符；  
\[]: 指定范围内的任意单个字符；[a-z]  
\[0-9]: 所有的数字  
 [a-z]：所有的小写字母  
 [A-Z]：所有的大写字母  
 [a-zA-Z]：所有的字母  
 [0-9a-zA-Z]：所有的数字和字母  
  
字符集合：  
 \[:digit:] : 所有数字, 相当于0-9  
 \[:lower:]:所有的小写字母  
 \[:upper:]:所有的大写字母  
 \[:alpha:]: 所有的字母  
 \[:alnum:]: 相当于[0-9a-zA-Z]  
 \[:space:]: 空白字符  
 \[:punct:]：所有标点符号  
  
注意：[a-zA-Z]这类型的不区分大小写  
 字符集合中，[]是这个符号的本身，而不是上面所说的任意耽搁字符  
 比如我们要表示[0-9]则是[[:digit:]]  
举例：  
1.查找以数字结尾的文件  
ls \*[0-9]  
2.查找以大写字母开头的文件  
ls [[:lower:]]\*  
