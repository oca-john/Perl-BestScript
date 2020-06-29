#!/usr/bin/perl
use warnings;

# 从文件接受序列
open(IN, "<inp.txt") or die "inp.txt 文件无法打开, $!";
@seqs = <IN>;
open(OUT, ">output.txt");
# 逐行读取
while ($seqs = <@seqs>){
    chomp $seqs;
    $ca = $seqs =~ tr/(Aa)/(Aa)/; $ct = $seqs =~ tr/(Tt)/(Tt)/; $cc = $seqs =~ tr/(Cc)/(Cc)/; $cg = $seqs =~ tr/(Gg)/(Gg)/;
    $lth = length($seqs);
    $cat = $ca + $ct; $ccg = $cc + $cg; $pat = $cat / $lth; $pcg = $ccg / $lth; $tm = 2*$cat + 4*$ccg;

    if ($seqs =~ /^>\w+/){
        print OUT "$seqs\n";
    }
    else {
    print OUT "A:$ca\t\tT:$ct\t\tC:$cc\t\tG:$cg\tAT:$cat\tCG:$ccg\tAT%:$pat\tCG%:$pcg\tTm:$tm\n";
    }
}

# 断开句柄
close (IN);
close (OUT);

# 目前问题：逐行读取的时候会把第一行分隔的字符当做多行处理（循环语句）。而且会将第一行也统计信息（条件语句）。
# 解决方案：首行规定不许有空格。
