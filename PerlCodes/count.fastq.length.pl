#!/usr/bin/perl -w
# 此脚本用于统计FASTQ文件的序列数目和平均长度;

# while循环将DNA序列提取，计数，并存入@res数组；同时计算提取次数，即序列数；
$t=0;			# DNA序列所在行号；
$n=0;			# 用于统计DNA序列数；最终的$t=($n-1)*4+2;
while ($line = <>) {			# 从外部文件读入第1行内容存为$line；
	$t++;						# 每次被next语句返回之前都加1，可用作计行号；
	next if ($t != $n*4+2);		# 用下一次匹配的$t和$n的关系，预检测下次是否可用；
	chomp $line;				# 去尾；
	@devi = split ("", $line);	# 分割为数组@devi；
	$len=scalar (@devi);		# 用$替换读长，存入$len；
	push (@res, "$len\n");		# 将$len加入到@res数组的尾部；
	$n++;						# 每次循环增加一次计数，即最终DNA条数；
}

# 通过迭代的累加，计算@res数组中记录的所有序列长度的总和，以及平均数；
$sum+=$_ foreach @res;			# 迭代计算序列长度总和；
$avg=$sum/$n;					# 计算均值；

# 输出统计结果；
print " there are $n reads, \n and the average read length is $avg.\n";
