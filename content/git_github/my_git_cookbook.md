Title: My Git cookbook
Date: 2014-10-24 22:54
Tags: git
category: Git&Github


我的Git常用命令  
==============

####1.创建仓库<kbd>git init</kbd>    
  
####2.添加文件到暂存区 <kbd>git add</kbd>

####3.从赞存区中删除文件，也就是不让index跟踪该文件 <kbd>git rm</kbd>
   * 如果我们只是不让index记录该文件，但是还让该文件留在工作区，使用 <kbd>git rm --cached file-name... </kbd>
   * 如果要让文件从本地删除，同时也从index中删除，使用 <kbd>git rm -f file-name... </kbd>
   
####3.提交到仓库 <kbd>git commit</kbd>   
   
####4.推送本地仓库到远程仓库 <kbd>git push</kbd>

####5.把远程仓库拉到本地 <kbd>git fetch</kbd>
