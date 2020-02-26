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

```markdown
0. 工作方式，写脚本，运行
1. 简单的打印方式,语法元素（数字、字符串、变量、运算符、转义符）
2. 语法结构（顺序执行、循环结构（for、while）、选择结构（if）、跳过与终止）
3. 文件读写
4. 正则表达式
5. 定义函数、调用函数
6. 组织模块、调用模块
7. 类、对象、继承性
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

### 1.2 Input

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

### 1.3 Operators

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
%a = ('mango'=>40,'banana'=>10,'cherry'=>20);	# define a hash
%a = ('mango',40,'banana',10,'cherry',20)
print $a{'mango'},"\n";				# get 40
%b = ('y'=>"Hello",'z'=>4);
$b{'x'} = 10;						# add an key-value pair, 'x'=>10
keys($b);							# get all keys of hash
values(%b);							# get all values of hash
exists($b{'ex'});					# if 'ex' exists in %b
delete($b{'x'});					# delete pairs, key = 'x'
@c = @b{'x','y'};					# pick the values of 'x','y' into @c
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

### 2.2 while, until

```perl
$i = 1;
while ($i<=4){						# condition $i<=4
  print $i*14,"\n";					# output $i*14
  $i++;
}
____________________________________
$a = 5;								# while loop
$b = 1;
while ($a>0){
  while ($b<=5){					# condition $a>0 and $b<=5
    print "*"x$b,"\n";				# output "*"x$b
    $b++;
    $a--;
  }
}
____________________________________
last;								# exit the loop, as 'break' in C++ or Python
$i = 5;
LOOP_OUTER: while ($i>=0){			# LOOP_OUTER is the label of the out loop
  $j = 5;
  print "i is ",$i,"\n";
  LOOP_INNER: while ($j>=0){
    print "j is ",$j,"\n";
    if($i==3){
      last LOOP_OUTER;				# break/exit the LOOP_OUTER
    }
    $j--;
  }
  $i--;
}
____________________________________
next;								# skip the loop, as 'continue' in C++ or Python
$i = 5;
while ($i>=0){
  if ($i == 2){
    $i--;							# if $i==2, just $i-1, and do nothing
    next;							# pass/continue the current loop
  }
  print $i,"\n";
  $i--;
}
____________________________________
$i = 0;								# until loop
until ($i>5){						# when $i>5 is False, do the loop
  print $i,"\n";
  $i = $i+1;
}
____________________________________
$a = 1 ;							# do...while
do{
  print ( "Hello World\n" ) ;		# like the simple while loop
  $a++;
}while ( $a <= 10 );				# condition in last
____________________________________
$i = 5;								# redo
while ($i>0){
  print "i is $i\n";
  if ($i == 1){					# $i==1, redo the loop, though $i>0 is False next time
    $i--;
    redo;							# redo the loop, not evaluating the condition
  }
  $i--;
}
____________________________________
$i = 5;								# goto
LOOP: while ($i>0){					# label the block as LOOP
  if ($i == 2){
    $i--;
    goto LOOP;						# goto the LOOP, jump the last codes
  }
  print "i is $i\n";
  $i--;
}
```

### 2.3 For, Foreach

```perl
for ( $a = 1 ; $a <= 10 ; $a ++ )	# init, condition, step
   {
     print ( "Hello World\n" ) ;
   }
____________________________________
for $a (1..5)						# for $a in range (1..5)
   {
     print $a,"\n";
   }
____________________________________
@a = (1,3,5,6,9);
foreach $b (@a)						# for $b eq every ele in the array
   {
     print $b,"\n";
   }
```

## 3. File and Directory I/O

### 3.1 File I/O

```perl
open (my $fh, "<", "test.txt") or die "Can't open < test.txt: $!";	# open file,<
print readline($fh);									# read file line by line
close($fh) or  "Couldn't close the file: $!";			# close file
____________________________________
open (my $fh, ">", "new.txt") or die "Can't open > test.txt: $!";	# open file,>
print $fh "I am new file\n";							# write file
close($fh) or  "Couldn't close the file: $!";
open (my $fh, "<", "new.txt") or die "Can't open < test.txt: $!";	# reopen,<
print readline($fh);
close($fh) or  "Couldn't close the file: $!";
____________________________________
rename("dest.txt","best.txt");							# rename a file
unlink("best.txt");										# delete a file
____________________________________
# here use the '$fh' as FILEHANDLE, use 'my' to make it as a local var
```

### 3.2 Directory

```perl
mkdir(new_dir) or die "Can't create directory $_";		# make dir
chdir("/dir_name") or die "Can't create directory $_";	# cd to a dir
rmdir(new_dir) or die "Can't create directory $_";		# remove dir
____________________________________
use Cwd;
my $pwd = cwd();					# get the working dir, by cwd()
print "$pwd\n";
____________________________________
opendir my $dir, "$pwd" or die "Cannot open directory: $!";
my @files = readdir $dir;			# read the dir $dir(FILEHANDLE)
foreach $i (@files){
  print "$i\n";						# print filename
}
closedir $dir;
____________________________________
$pm = "*.pl *.pm";
my @files = glob($pm);				# select files with .pl or .pm
foreach $i (@files){
  print "$i\n";						# print filename
}
```

## 4. Regular expressions

```perl
Meta Chr:
{}[]()^$.|*+?\				# they have special means, use \ to transform
Operations:
m, match; s, substitute; tr, translate;
$str =~ /regular_expression/		# comman RE
$str !~ m/regular_expression/		# '!~' means NOT, 'm' means match
$str =~ s/old/new/i;				# substitute 'old' with 'new',case-insensitive
$str =~ tr/[a-z]/[A-Z]/;			# trans [a-z] to [A-Z]
```

### 4.1 chr in special

| chr  | means     | chr  | means          |
| ---- | --------- | ---- | -------------- |
| /w   | word      | /d   | digit, num     |
| /W   | NOT word  | /D   | NOT digit, num |
| /s   | space     | /t   | tab            |
| /S   | NOT space | /n   | new line       |
| /e   | escape    | /r   | return         |
| .    | any chr   |      |                |

### 4.2 group and select

```perl 
$str =~ m/(a|b|c)/;					# match 'a' or 'b' or 'c'
```

### 4.3 classes

| class       | means            | class       | means          |
| ----------- | ---------------- | ----------- | -------------- |
| [abcde]     | a chr in [abcde] |             |                |
| [0-9]       | 1 num            | [0-9]+      | 1 or multi num |
| [A-Za-z]{3} | 3 chr            | [*!@#$%&()] | 1 chr in []    |

### 4.4 times

| chr  | times         | chr   | times             |
| ---- | ------------- | ----- | ----------------- |
| ?    | 0, 1 time     | {n}   | n times           |
| +    | 1 - any times | {n,}  | n times, at least |
| *    | 0 - any times | {n,m} | n - m times       |

### 4.5 place

| chr  | place           | chr  | place         |
| ---- | --------------- | ---- | ------------- |
| ^    | start of string | $    | end of string |

```perl
if ("car" =~ /[^c]ar/){				# NOT start wich c, '^' in [], means NOT
  print "It is not a car.\n";		# aar, bar, dar will be match
}
else{
  print "It is a car\n";
}
____________________________________
@a = (1,'a',2,'b',3,'c',4,'d',5,'e');
@num = grep(/\d/,@a);				# use grep to pick '\d', digit or num
print "@num\n";						# get the array, (1,2,3,4,5)
```

## 5. Function

```perl
sub print_hello{					# define a function, by 'sub func_name{BLOCK}'
	print "hello boy!";
}
print_hello();						# use the fuction, by 'func_name()'
____________________________________
sub is_even{
  $x = $_[0];						# get the arg, by $_[0]
  if ($x%2 == 0){					# $x%2 == 0, even
    print "even\n";
  }
  else{
    print "odd\n";					# $x%2 != 0, odd
  }
}
is_even(2);							# even
is_even(3);							# odd
____________________________________
sub sum{
  $s = 0;
  foreach $i (@_){					# get each arg, by foreach loop
    $s = $s + $i;					# sum it
  }
  print "$s\n";						# output the result
}
sum(2,5);
sum(5,2,3);
____________________________________
sub is_even{						# return a value
  $x = $_[0];
  if ($x%2 == 0){
    return 1;						# return a num, can be any num
  }
  else{
    return 0;						# return a num
  }
}
print is_even(1),"\n";				# use the return num 0, 1, like True or False
print is_even(2),"\n";
____________________________________
sub fac{							# recursion
  my($x) = $_[0];
  if ($x == 0 || $x == 1){			# input 0/1, output 1
    return 1;
  }
  else{
    return $x*fac($x-1);			# recursion, use the fac() many times
  }
}
print fac(0),"\n";					# 1
print fac(1),"\n";					# 1
print fac(4),"\n";					# 4*3*2*1 = 24
print fac(5),"\n";					# 5*4*3*2*1 = 120
```

## 6. Modules

### 6.1 Declaring a module

```perl
#File name is p.pm
use strict;
use warnings;
package p;							# Declaring package p

sub Hello{
  print "Hello\n";
}
1;
```

### 6.2 Use a module

```perl
use p;								# use the p.pm module
use dir::p;							# if p.pm is under 'dir'
p::Hello();							# use the function in p.pm
```

### 6.3 Use var from module

```perl
package b;							# Declaring package p

our ($var_name);

sub Hello{
  print "Hello $var_name\n";
}
1;
____________________________________
use p;								# using package p

$p::var_name = "Sam";				# using var_name from p
p::Hello();							# Function Hello of p
```

### 6.4 BEGIN, END

```perl
BEGIN{								# block in the BEGIN
  print "Starting...\n";
}
END{								# block in the END
  print "END OF PROGRAM\n";
}

print "Hello World;\n";
```

## 7. Classes, Objects, Inheritance

### 7.1 Constructor

```perl
use strict;
use warnings;
package Student;					# define the module

sub new{							# constructor named 'new'
  #the package name 'Student' is in the default array @_
  #shift will take package name 'student' and assign it to variable 'class'
  my $class = shift;				# produce a class
  my $self = {						# produce a object
    'name' => shift,
    'roll_number' => shift
  };
  bless $self, $class;				# blessing self to be object in class
  return $self;						# returning object from constructor
}
____________________________________
my $obj = new Student("Sam",01);	# use the function 'new', 
print "$obj->{'name'}\n";
```

### 7.2 Methods

```perl
package Square;						# define the module

sub new{							# constructor named 'new'
  my $class = shift;				# produce a class
  my $self = {						# produce a object
    'side' =>shift
  };
  bless $self, $class;				# blessing self to be object in class
  return $self;						# returning object from constructor
}

sub getPerimeter{					# method in class
  my $self = shift;
  return 4*$self->{'side'};
}

sub getArea{						# method in class
  my $self = shift;
  return $self->{'side'}*$self->{'side'};
}
1;
____________________________________
use Square;							# use package
my $obj = new Square(10);			# use constructor & function
print $obj->getPerimeter(),"\n";
print $obj->getArea(),"\n";
```

### 7.3 isa, can

| function | means                                                      |
| -------- | ---------------------------------------------------------- |
| isa()    | check if an object is object of a class or not             |
| can()    | check if an object or class has a particular method or not |

```perl
use Square;							# use package
my $obj = new Square(10);
print $obj->isa('Square'),"\n";
print $obj->can('getArea'),"\n";
```

### 7.4  Creating default attribute

```perl
package Square;						# define the module

sub new{
  my $class = shift;
  my $self = {
    'side' =>shift || 1
  };
  bless $self, $class;
  return $self;
}

sub getPerimeter{					# method in class
  my $self = shift;
  return 4*$self->{'side'};
}

sub getArea{
  my $self = shift;
  return $self->{'side'}*$self->{'side'};
}
1;
____________________________________
use Square;							# use package
my $obj = new Square();
print $obj->getPerimeter(),"\n";
print $obj->getArea(),"\n";
```

### 7.5 Destructors

```perl
package Square;						# define the module

sub new{
  my $class = shift;
  my $self = {
    'side' =>shift || 1
  };
  bless $self, $class;
  return $self;
}

sub DESTROY {
    my $self = shift;
    print "DESTROYED\n";
}

sub getPerimeter{					# method in class
  my $self = shift;
  return 4*$self->{'side'};
}

sub getArea{
  my $self = shift;
  return $self->{'side'}*$self->{'side'};
}
1;
```

### 7.6 Inheritance

```perl
#file is Student.pm
use strict;
use warnings;
package Student;					# define the module

sub new{
  my $class = shift;
  my $self = {
    'name' => shift,
    'roll_number' => shift
  };
  bless $self, $class;
  return $self;
}
1;
____________________________________
#file is Btech.pm
package Btech;						# define the module
use parent 'Student';				# use package
1;
____________________________________
use Btech;
my $a = Btech->new("Sam",01);
print "$a->{'name'}\n";
print "$a->{'roll_number'}\n";
```

### 7.7  Method overriding

```perl
#This is Rectangle.pm
use strict;
use warnings;
package Rectangle;					# define the module

sub new{
  my $class = shift;
  my $self = {
    'length' =>shift,
    'breadth' =>shift
  };
  bless $self, $class;
  return $self;
}

sub getPerimeter{
  my $self = shift;
  print "Perimeter of rectangle is ",2*($self->{'length'}+$self->{'breadth'}),"\n";
}

sub getArea{
  my $self = shift;
  return $self->{'length'}*$self->{'breadth'};
}
1;
____________________________________
#file is Square.pm
package Square;						# define the module
use parent 'Rectangle';				# use package

sub getPerimeter{
  my $self = shift;
  print "Perimeter of square is ",4*($self->{'length'}),"\n";
}
1;
____________________________________
use Square;							# use package
my $a = Rectangle->new(5,10);
my $b = Square->new(4,4);
$a->getPerimeter();
$b->getPerimeter();
```

