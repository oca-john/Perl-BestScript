#!/usr/bin/perl
# 只读方式打开文件
open(DATA1, "<file1.txt");
 
# 打开新文件并写入
open(DATA2, ">file2.txt");
 
# 拷贝数据
while(<DATA1>)
{
   print DATA2 $_;
}
close( DATA1 );
close( DATA2 );
