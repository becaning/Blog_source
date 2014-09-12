Title: grep的基本使用和常见参数    
Date: 2014-04-09 13:14
Tags: grep
category: blog
  
写在前面：本文着重介绍grep的使用方法以及其各参数的使用，不介绍正则表达式的内容。  
#What is grep?  
grep 是 Global search Regular Exmpression and Printing的缩写，  
即以正则表达式的模式做全局搜索。  
#什么时候用?  
当我们要查看某个文件或某些文件的内容中是否有我们想要的内容。  
<!--more-->
#如何使用grep?  
知道grep是什么了，也知道我们什么时候要用了，我们就来看看如何玩转grep  
废话不多说，先看一下帮助文档:  
用法: grep [选项]... PATTERN [FILE]...  
在每个 FILE 或是标准输入中查找 PATTERN。  
默认的 PATTERN 是一个基本正则表达式(缩写为 BRE)。  
例如: grep -i 'hello world' menu.h main.c  
  
正则表达式选择与解释:  
```bash  
  -E, --extended-regexp     PATTERN 是一个可扩展的正则表达式(缩写为 ERE)  
  -F, --fixed-strings       PATTERN 是一组由断行符分隔的定长字符串。  
  -G, --basic-regexp        PATTERN 是一个基本正则表达式(缩写为 BRE)  
  -P, --perl-regexp         PATTERN 是一个 Perl 正则表达式  
  -e, --regexp=PATTERN      用 PATTERN 来进行匹配操作  
  -f, --file=FILE           从 FILE 中取得 PATTERN  
  -i, --ignore-case         忽略大小写  
  -w, --word-regexp         强制 PATTERN 仅完全匹配字词  
  -x, --line-regexp         强制 PATTERN 仅完全匹配一行  
  -z, --null-data           一个 0 字节的数据行，但不是空行  
  
Miscellaneous:  
  -s, --no-messages         suppress error messages  
  -v, --invert-match        select non-matching lines  
  -V, --version             print version information and exit  
      --help                display this help and exit  
      --mmap                ignored for backwards compatibility  
  
Output control:  
  -m, --max-count=NUM       stop after NUM matches  
  -b, --byte-offset         print the byte offset with output lines  
  -n, --line-number         print line number with output lines  
      --line-buffered       flush output on every line  
  -H, --with-filename       print the filename for each match  
  -h, --no-filename         suppress the prefixing filename on output  
      --label=LABEL         print LABEL as filename for standard input  
  -o, --only-matching       show only the part of a line matching PATTERN  
  -q, --quiet, --silent     suppress all normal output  
      --binary-files=TYPE   assume that binary files are TYPE;  
                            TYPE is `binary', `text', or `without-match'  
  -a, --text                equivalent to --binary-files=text  
  -I                        equivalent to --binary-files=without-match  
  -d, --directories=ACTION  how to handle directories;  
                            ACTION is `read', `recurse', or `skip'  
  -D, --devices=ACTION      how to handle devices, FIFOs and sockets;  
                            ACTION is `read' or `skip'  
  -R, -r, --recursive       equivalent to --directories=recurse  
      --include=FILE_PATTERN  search only files that match FILE_PATTERN  
      --exclude=FILE_PATTERN  skip files and directories matching FILE_PATTERN  
      --exclude-from=FILE   skip files matching any file pattern from FILE  
      --exclude-dir=PATTERN  directories that match PATTERN will be skipped.  
  -L, --files-without-match  print only names of FILEs containing no match  
  -l, --files-with-matches  print only names of FILEs containing matches  
  -c, --count               print only a count of matching lines per FILE  
  -T, --initial-tab         make tabs line up (if needed)  
  -Z, --null                print 0 byte after FILE name  
  
Context control:  
  -B, --before-context=NUM  print NUM lines of leading context  
  -A, --after-context=NUM   print NUM lines of trailing context  
  -C, --context=NUM         print NUM lines of output context  
  -NUM                      same as --context=NUM  
      --color[=WHEN],  
      --colour[=WHEN]       use markers to highlight the matching strings;  
                            WHEN is `always', `never', or `auto'  
  -U, --binary              do not strip CR characters at EOL (MSDOS)  
  -u, --unix-byte-offsets   report offsets as if CRs were not there (MSDOS)  
``` 
这个命令的使用方法还是很简单的，就是选项有点多(^_^)  
**grep [选项] "匹配模式" 文件(一个或多个)**  
匹配模式：也就是我们提出的条件，就比如你对朋友说：把你认识的所有‘妹子’的电话号码给我，那么这里的‘妹子’就是一个匹配模式。这个匹配模式一般使用正则表达式，内容比较多，这里不讨论。  
  
选项：我们重点来看看常用选项，按照帮助手册来看，选项分为匹配模式选择的，输出控制的，文本控制的还有就是常规同样的。  
匹配模式的选择：常用的有-E,-i,-w,-x.  
	-E:如果加这个选项，那么后面的匹配模式就是扩展的正则表达式，也就是grep -E = egrep.  
	-i:忽略大小写  
	-w:匹配单词，相当于正则中的"\<...\>"(...表示你自定义的规则)  
	-x:匹配一行，相当于正则中的"^...$"(...表示你自定义的规则)  
  
常规通用的选项：一般用的就是-v选项  
	-v:取反，也就是输出我们定义的模式相反的内容。  
  
输出控制：这个比较多，来几个最常用的吧，  
	-m:只匹配规定的行数，之后的内容就不在匹配了。  
	-n:在输出的结果里显示行号，这里要清楚的是这里所谓的行号是该行内容在原文件中的行号，而不是在输出结果中的行号。  
	-o:只显示匹配内容，grep默认是显示满足匹配条件的一行，加上这个参数就只显示匹配结果，比如我们要匹配一个ip地址，就只需要结果，而不需要该行的内容。  
	-R:递归匹配。如果要在一个目录中的多个文件或目录匹配内容，则需要这个参数。  
	-c:count.统计，统计匹配结果的行数，主要不是匹配结果的次数，是行数。  
  
文本控制：其实和输出控制差不多，常用的有三个  
	-B：输出满足条件行的前几行，比如grep -B 3 "aa" file 表示在file中输出有aa的行，同时还要输出aa的前3行。  
	-A：这个与-B类似，输出满足条件行的后几行。  
	-C：这个相当于同时用-B -A，也就是前后都输出。  
  
  
好了，grep的用法就到这里了，这里只是列出了常用的选项，还有很多选项请man，grep非常有用，大家一定有掌握好。  
