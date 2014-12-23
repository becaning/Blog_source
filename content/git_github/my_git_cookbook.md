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

   
####4.推送本地仓库到远程仓库 `git push remote_repo [local_br]:[remote_br]`
   * `remote_repo`是远程仓库，`local_br`是本地分支，`remote_br`是远程分支。也就是把本地分支`local_br`推送到远程仓库`remote_repo`的`remote_br`分支上.  
   * 如果远程仓库中只有一个分支或者`remote_br`是远程仓库的默认分支，则`remote_br`可以省略不写。即:`git push remote_repo local_br`.  
   * 如果不写本地分支而写了远程分支，即:`git push remote_repo :remote_br`,这就相当于把本地的什么都没有推向远程的`remote_br`分支，这样会删除远程分支`remote_br`.  
   

####5.把远程仓库拉到本地 `git pull remote_repo [remote_br]:[local_br]`

####6.时空穿梭
   * 1).现在正处于一个commit上,而且没有新的修改,这时需要回到上一个版本`git reset --hard HEAD^`.如果是回到之前的`n`个版本`git reset --hard HEAD~n`.  
   * 2).现在正处于一个commit上,某一个文件发生了修改,但是还没有`git add`到`暂存区`中,这时如果我们需要抹掉这些修改 `git checkout -- file`.
   * 3).现在正处于一个commit上,某一个文件发生了修改,而且还`git add`到`暂存区`中,这时我们需要回退的话,需要两步操作，使用`git reset HEAD file`来抹掉`暂存区`中的修改部分.这是还有`工作区`中的文件内容还没有还原，这时候的情况和上面`2)`是相同的,所以使用`git checkout -- file`
