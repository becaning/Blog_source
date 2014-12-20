Title: My Git cookbook
Date: 2014-10-24 22:54
Tags: git
category: Git&Github


我的Git常用命令  
==============

####1.创建仓库`git init`  
  
####2.添加文件到暂存区 `git add`

####3.从赞存区中删除文件，也就是不让index跟踪该文件 `git rm`
   * 如果我们只是不让index记录该文件，但是还让该文件留在工作区，使用 `git rm --cached file-name... `
   * 如果要让文件从本地删除，同时也从index中删除，使用 `git rm -f file-name... `
   * 其实index文件中记录所有下次会做成一个版本的文件，可以使用`git ls-files`查看
   
####3.提交到仓库 `git commit`   
   
####4.推送本地仓库到远程仓库 `git push`

####5.把远程仓库拉到本地 `git fetch`
