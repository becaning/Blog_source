Title: python字符串操作   
Date: 2014-10-28 20:01   
Tags: python   
category: python      
   
   
1.字符串格式化   
--------------   
* 在旧版本的python中，字符串的格式化和C语言很相似，但是从2.6之后增加了format函数，非常好用。     
format是字符串对象的一个方法，基本使用是使用{}作为占位符。   
```bash   
In [3]: 'hello {},hello {}'.format('tom','jerry')   
Out[3]: 'hello tom,hello jerry'   
```   
   
* 如果只是简单的在字符串中使用{}作为占位符，那么format中接受到的参数将一个个放到对应位置。其实我们是可以任意调整位置的。   
```bash   
In [4]: 'hello {1},hello {0}'.format('tom','jerry')   
Out[4]: 'hello jerry,hello tom'   
```   
   
* 除了上面使用数字来调整顺序，我们还可以使用key来键映射。     
```bash   
In [5]: 'hello {name1},hello {name2}'.format(name1='tom',name2='jerry')   
Out[5]: 'hello tom,hello jerry'   
```   
   
* 上面的都是把一个值放到一个对应的占位符处，其实传给占位符的值还可以做一些处理。     
```bash   
In [6]: 'hello {0[1]},hello {0[3]}'.format('123456')   
Out[6]: 'hello 2,hello 4'   
```   
   
* 同样，我们也可以在键映射中使用这一的处理。   
```bash   
In [7]: 'hello {num[1]},hello {num[3]}'.format(num = '123456')   
Out[7]: 'hello 2,hello 4'   
```   
   
* 除了上面的基本填充之外，我们还可以给'填充物'加一下格式。   
语法：{:},和上面相同的是使用{}作为占位符，不同的是多了冒号 <code>:</code>,在冒号的前面和上面提到的使用方法相同，可以什么也不写，可以使用数字，也可以使用key和下标。那么在冒号的后面就是我们要使用的格式。   
#####格式:   

1.使用 <,^,>分别表示左对齐，居中，右对齐。   
```bash   
In [15]: '{0:#<10}   |   {0:*^12}    |   {0:&>10}'.format('ok')   
   
Out[15]: 'ok########   |   *****ok*****    |   &&&&&&&&ok'
```
PS:以#<10为例，#表示用#来填充，<表示左对齐，10表示如果字符串不够10个字符就用#来填充。  

2.数字的进制，b,d,o,x分别表示二进制，十进制，八进制和十六进制。

