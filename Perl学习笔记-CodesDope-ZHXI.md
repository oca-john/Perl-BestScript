# Perl学习笔记-CodesDope-ZHXI

- From [https://www.codesdope.com](https://www.codesdope.com/) 

## 0. Introduction

```perl
#!/usr/bin/perl -w
print "hello world!";		# print strings directly, end a line with ";"
```

1. Edit the perl script file with Vim or VScode.
2. cd to the directory which include the script file.
3. Type `perl file_l.pl`, to run.

```
0.工作方式，写脚本，运行
1.简单的打印方式
2.语法元素（数字、字符串、变量、运算符、转义符）
3.语法结构（顺序执行、循环结构（for、while）、选择结构（if）、跳过与终止）
4.文件读写
5.正则表达式
6.定义函数、调用函数
7.组织模块、调用模块
8.类、对象、继承性
```

## 1. Elements

### 1.1 Print

```perl
print "hello world!\nnext line"		# \n means newline
____________________________________
print "the 1st line";				# space between "" will keep the real state
print "the 2nd line";				# ; means new sentence in grammer
print "the 1st word",  "the 2nd word";
print "the 1st word,
		the 3nd word";				# spaces out of the "" means nothing
____________________________________
print "hello 1st\n";				# use the say by `use feature ":5.26";`
say "hello 2nd";					# includes "\n" by default, special in v5.2.
print "hello 3rd\n";
____________________________________
print "hello world\n"				# vars will be translated
print 'hello world\n'				# vars will keep as themselves
____________________________________
$a = 1024;
print "$a\n";						# def a var & print it
$c = $a + $b;						# combine two strings, or add two numbers
____________________________________
$str = <<"ENDBLK";					# def a var by here doc
hello,								# start with <<"END", end_line with 'END'
	you can
print anything here
in multilines
ENDBLK
print "$str";						# use the here doc
____________________________________
$a = 10.032; print int($a),"\n";	# pick the int part of a float num
print "one\ttwo\nthree\"four\$five\@six\%seven\\eight";	# show the symble itselft
____________________________________
($a,$b) = ($b,$a)					# swap two vars' value
____________________________________
print sprintf ("my name is %s, and I am %i year old", "Sam",19)	# print string in format
									# %s means a string(Sam), %i means a int_num(19)
```

## 1.2 Input

```perl
print "what is your name?\n";
$name = <>;							# pick the input value by <>
chomp($name);						# chomp the end of $name
print "Your name is ", $name, "\n";	# use the $name var
print $name*3,"\n";					# pring string 3 times
____________________________________
print "enter a numver\n";
$num = <>;							# in fact, you get a var with uncertain type
$num = $sum*1;						# convert to int
____________________________________
# command line arguments
perl filename.pl 5 10				# 5,10 are two arguments
​```
print $ARGV[0]+$ARGV[1], "\n";		# $ARGV[index] receive the arguments
​```
```

## 1.3 Operators

```perl
0, "", undef						# all these three are FALSE
others								# TRUE
&& = AND, || = OR, ! = NOT			# logical AND, OR, NOT
+, -, *, /, %, **					# add, subtract, multiply, divides, modulus, exponent
=									# assigns
+=, -=, *=, /=, %=, **=				# add & assigns, subtract & assigns,...
==, !=, >, <, >=, <=				# compare two values
eq, ne, gt, lt, ge, le				# compare two values
```

### 1.4 String

```perl
print "a"x3,"\n";					# print string "a" 3 times
length($a);							# get the length of $a
____________________________________
$a = "abcdefg";						# substr(string, start, length)
print substr($a,0,3)				# from 0 pick 3 substrings, finnally get 'abc'
____________________________________
print chr(70),"\n";					# from the ASCII table, pick the char by index 70
____________________________________
lc, lcfirst, uc, ucfirst			# chage the char in lowercase, uppercase
____________________________________
@a = split(/-/, "1-2-3-4");			# split a string var into an array
join(".", (1,2,3,4)),"\n";			# join an array into a string var
```

### 1.5 Array

```perl
@a = (1,2); @b = ("a","b");			# assign a array
print $b[0],"\n";					# pick a ele by index(start from 0)
@c = (1..5); @d = ("a".."e");		# produce num/char by order
____________________________________
scalar@c;							# size of @c, (=5)
$#c;								# max index of @c, (=4)
@e = (1,2,5,2,6);					# define an array
$a[29] = 23;						# expand the array to the index [29]
scalar@e; $#e;						# will be 30, and 29
____________________________________
@f = (1,2,3,4,5,6,7,8);
$sum = 0;							# init the sum
$i = 0;								# init the index
while ($i < scalar@f) {				# when array is not end
	$sum = $sum + $f[$i];			# sum it
	$i++;							# step is 1
}
print $sum,"\n";
____________________________________
@g = @f[1,4,6];						# slicing part of array
@g = @f[2..5];
____________________________________
@h = ((1,2,3),(4,3,6),(7,4,2));		# use "," to join array directly
____________________________________
@i = (1,2,3); 
push(@i,7);							# out: (1,2,3,7)
pop(@i);							# out: (1,2)
shift(@i);							# out: (2,3)
unshift(@i,7);						# out: (7,1,2,3)
reverse(@i);						# out: (3,2,1)
join("o",@i);						# out: 1o2o3
map{$_+3} @i;						# out: (4,5,6), transform every ele
@k = (1,13,2,4); @l = ("a","e","d");
sort(@k);							# out: (1,13,2,4)
sort(@l);							# out: ("a","d","e")
sort{$a<=>$b} @k;					# out: (1,2,4,13)
sort{$b<=>$a} @k;					# out: (13,4,2,1)
```

### 1.6 Hash

```perl

```



## 2. Structure

### 2.1 if...else...

```perl
$a = <>;							# assign a var
chomp($a);							# remove the end
if ($a>10) {						# comparation
	print "your num is greater than 10\n";
}
elsif ($a==10) {					# under comparation
	print "your num is eq to 10\n";
}
else{
	print "your num is less than 10\n";
}
____________________________________
unless ($a>10) {					# comparation
	print "your num is greater than 10\n";
}
else {
	print "your num is less than 10\n";
}
____________________________________
condition ? exp_1 : exp_2;			# if condition is true, do exp_1, or do exp_2
($a>10) ? print("your num is greater than 10\n") : print("your num is less than 10\n");
____________________________________
$a = 2;{
	my ($a) = 3;					# my define a local var
	print $a,",inner\n";
}
print $a,",outer\n";
```

