Title: VIM小技巧  
Date: 2014-04-12 06:51
Tags: vim   
category: vim

**本文收录我平时使用VIM是学习到的小技巧，持续更新**  
**本文是持续更新的，所列出的条目没有先后难易之分**  
  
###1)、vim中查看目录  
在vim中没有插件也可以查看目录，使用<code>:E</code>命令  
![使用:E的效果](http://becaning-github-io.qiniudn.com/vim_tips11111.png)  
从这张图片可以看到，在使用**:E**命令之后，会列出当前目录中所有的文件和目录，可以上下移动光标到你想要的文件或目录上，敲Enter键打开，除了基本的打开文件之外，还有其他命令，比如: **s:sort-by**等，但是在命令行中打开的vim不会显示帮助，所以我打开了图形界面的vim来演示效果，其他命令如图中所示。  

###2)、在vim完成英文单词补全  
在平常的文本书写中，偶尔会忘记一个单词怎么写了，记忆模模糊糊的，这时候就可以用到这个功能了。  
其实现原理为：在操作系统中自带了一个字典文件<code>/usr/share/dict/words</code>,通过配置vim去在这个字典文件中查找你需要的单词。

* 操作:
```bash
#在.vimrc文件中添加如下一行
set dictionary+=/usr/share/dict/words
```
配置完成之后重新打开vim。当你需要补全某个单词是按键<kbd>Ctrl + x + k</kbd>。 

* Example  
当我在写文本是需要键入<code>protocol</code>这个单词，正好忘记了。  
我先键入<code>pro</code>,然后按键<kbd>Ctrl + x + k</kbd>,然后根据提示就可以完成单词了。  
  
![word complete](/theme/assets/images/vim-tips/word-complete.png)







































