Title: Bash脚本编程  
Date: 2014-09-13 23:50
Tags: shell 
Category: Linux


Bash脚本之变量  
=============

###变量杂说  

* shell的变量与其他编程语言的变量没有任何区别:动态创建，按需创建，无需预先定义，随时可以删除。  
* 变量名有字母数字下划线组成，如：var,_var,var123...  
* 给变量赋值用<kbd>=</kbd>连接变量名与值，如：<kbd>var1='value'</kbd>,值得主要的是：等号<kbd>=</kbd>的两边不能用空格，这与其他语言不同。  
* bash的变量容纳的类型只有一种，那就是字符串，不管我们给它以什么样的方式赋值，它最终都是以字符串的形式来保存。  


###变量的类型
这里所说的类型不是变量的值的类型，而是由于变量在不同的位置被创建，它的作用域不同  

* <code>本地变量(局部变量)</code>:本地变量也就是我们最常见到的在编写脚本是随手定义的变量，这样的变量仅在当前shell进程有效  
* <code>环境变量</code>:环境变量用export定义，一旦定义在当前shell进程及其子进程都是有效的  
* <code>位置变量</code>:位置变量与我们运行脚本给定的参数有关，如：<kbd>test.sh -v</kbd>,这里的-v就可以在脚本中通过位置变量来接收，从脚本名开始往后走，分别是$0、$1、$2.
* <code>特殊变量(系统变量)</code>  


Bash脚本之流程控制  
==================

###条件测试  

* 在shell编程中，条件测试是一个很重要的话题，我们大多数时间都在进行条件测试，而且条件测试也是很容易出错的地方，有很多小细节需要注意。  
* 条件测试主要用的两个命令，分别是:<kbd>test</kbd>和<kbd>[</kbd>,伙计，你没有看错，<kbd>[</kbd>也是一个命令，和<kbd>test</kbd>几乎等价的，在我们平常写脚本的时候，为了增强可读性，会在<kbd>[</kbd>后面以<kbd>]</kbd>来结束条件测试，一定要注意，<kbd>[</kbd>后面有空格，否则会出错，当你把<kbd>[</kbd>真正看作一个命令，这一点也就好理解了。  
* 条件测试的类型主要有三种:字符串比较，算术比较以及文件相关的判断:  
    字符串比较：比较两个字符串是否相等，以及判断一个字符串是否存在，如：<kbd>str1 = str2,str1 !=str2,-n str1,...</kbd>   
    算术比较：比较两个数字大小关系，如：<kbd>3 lt 4...</kbd>  
    文件相关比较：主要用于判断一个文件的各种属性等等，如：<kbd>-f testfile...</kbd>   
    要查看详细的条件测试相关的内容敲命令：<kbd>help test</kbd>  

* 条件测试还可以组合使用，试想这种情况，当我挑选一个妹子，我们会要求她身材要好，皮肤要白，长相甜美，必须同时符合这些要求，这时我们就需要把这些条件组合起来去判断。用于连接这些组合条件的关键字有<kbd>AND</kbd>和<kbd>OR</kbd>

    1. AND：连接多个测试条件，如：<kbd>[ -f file AND 2 lt 3 ]</kbd>,这其实就是一个条件测试列表，每个测试从左至右一个一个执行，遇到Ture继续，遇到False就结束返回False即整体测试为False,如果列表执行完毕都为True，则整个测试的结果就是True。  
    2. OR：这个和AND差不多，也是从左至右执行，不同的是，当第一次遇到True时就返回True，不再执行后面的测试列表。如果整个测试列表执行完毕还没遇到False则返回False。  

###if分支语句  
* if分支语句理解起来就很简单啦，从上到下检查condition，当第一次遇到condition的结果为True时就执行内部的语句块statements，之后的condition不再执行，也就是说每个语句块是相互排斥的，每次只可能执行其中的一个，如果所有condition都是Ture，则执行else内部的语句块。

* ####Format:
```bash
|------第1种形式-------|
if condition  
then  
    statements  
    ...  
fi  

|------第2种形式-------|
if condition  
then  
    statements    
    ...  
else  
    statements    
    ...  
fi  

|------第3种形式-------|
if conditoin    
then  
    statements  
    ...  
elif condition    
then
    statements    
    ...  
else    
    statements    
    ...  
fi  
```

* ####Example:
```bash
#!/bin/bash

#Desc:判断性别，根据性别问好

gender=$1

if [ $gender = 'M' ]
then
    echo '先生你好，先生再见！'
elif [ $gender = 'F' ]
then
    echo '美女你好，美女拜拜！'
else
    echo '人妖一边去！'
fi
```


###case分支语句
* case分支语句和if语句非常类似，但case语句更简洁清晰，工作的基本思路是提供很多条目，然后根据一个表达式去从上到下匹配，一旦匹配到就执行对于的语句块，然后结束整个case语句，不再执行后面的语句。
* ###Format
```bash
case variable in
pattern1) 
    statements
    ...
    ;;
pattern2) 
    statements
    ...
    ;;
pattern3) 
    statements
    ...
    ;;
...
esca
```


###for循环语句

* for循环的本质就是遍历一个列表，每次到列表中读取一个value赋值给一个临时变量，然后执行执行for语句内部的语句块，然后再读取列表中的value，直到列表中的value被读完，循环结束。
* ####Example:
```bash
#!/bin/bash

for i in 1 2 3 4 5
do
    echo $i
done
```

* for语句中被遍历的列表可以用多种方式呈现：  

    1. 直接给出，如：<kbd>1 2 3 4 5 6</kbd>  
    2. 命令的返回结果，如：<kbd>\`seq 1 9\`</kbd>  
    3. 如果是数字则可以简写为<kbd>{1..9}</kbd>    


###while循环语句

* while循环与for循环不同之处在于while循环是一个条件式的循环，for循环是每次到列表中取一个值，而while循环则是每次判断一个条件测试，如果条件测试通过就继续执行循环体，否则结束循环。  
* ####Format:
```bash
while condition
do
    statements
    ...
done
```

* ####Example:
```bash
#!/bin/bash

i=0
while [ $i -lt 10 ]
do
    echo $i
    i=$(($i + 1))
done
```



Bash脚本之函数
==============

* 函数实质就是把一堆代码块包装到一起，在需要用的时候直接拿来就用,以此来实现代码重用。  
* 函数的主要由函数名和函数体构成，函数名的作用是在后续程序需要这部分代码块时通过该名称来引用代码块，函数体是有多条语句组成，也就是真正需要在调用出执行的代码。  
* ####Example:
```bash
#!/bin/bash

foo(){
    echo 'hello world'
}

#在这里用函数名foo来引用上面的函数，可以多次引用。
foo
foo
```



Bash脚本之关键字或命令  
=====================

* <code>break</code>:这个关键字出现在流程控制中的循环里，for循环，while循环以及until循环都可以用，它的作用是结束循环，当我们需要在循环体中结束循环是就使用break，如果在break后面加一个数字，则指定退出几层循环，当然这是可选的，不指定默认跳出一层。
* <code>continue</code>:和break不同的是，这个命令的作用是仅跳过当前次循环，继续执行下一次循环，而非结束循环。
* <code>:</code>:这个命令的作用就是什么也不做，基本就是站个位，但是由于shell脚本和其他语言的不同，这个命令还挺有用的，例如if语句中有什么需要什么也不做，但是bash不允许在if结构内部什么也不写，所以这个时候就<kbd>:</kbd>来站位。
* <code>exit</code>:<kbd>exit</kbd>为程序提供一个退出码。一般来说，程序正常退出返回0,非正常退出就会是1～125之间的一个数字。
* <code>export</code>:用于设置环境变量，如：export var='value',从此这个变量var就是一个环境变量，在当前shell及其子shell都有效。  
* <code>expr</code>:<kbd>expr</kbd>和<kbd>$(( ))</kbd>等价，用于数学计算，如果<kbd>expr 1 + 2</kbd>。
    
####待更新。。。
