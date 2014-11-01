Title: My Git cookbook
Date: 2014-10-24 22:54
Tags: git
category: Git&Github


我的Git常用命令  
==============

####1.创建仓库<code>git init</code>    
  
####2.添加文件到暂存区 <code>git add</code>

####3.从赞存区中删除文件，也就是不让index跟踪该文件 <code>git rm</code>
   * 如果我们只是不让index记录该文件，但是还让该文件留在工作区，使用 <code>git rm --cached file-name... </code>
   * 如果要让文件从本地删除，同时也从index中删除，使用 <code>git rm -f file-name... </code>
   * 其实index文件中记录所有下次会做成一个版本的文件，可以使用<code>git ls-files</code>查看
   
####3.提交到仓库 <code>git commit</code>   
   
####4.推送本地仓库到远程仓库 <code>git push</code>

####5.把远程仓库拉到本地 <code>git fetch</code>
