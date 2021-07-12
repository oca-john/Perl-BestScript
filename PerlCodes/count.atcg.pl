#!/usr/bin/perl -w
## 此脚本用于从FASTQ文件中提取基因序列，并计算同一位置上所有序列A/T/G/C碱基数，以及AT含量和GC含量；

push (@out, "a\tt\tg\tc\tat\tgc\n");
$ln=0;                          # 行号标记；
$nu=1;                          # DNA序号标记；
while ($line=<>) {
## 第一部分，逐行内容提取 ##
    $ln++;                      # 行号先+1，后续语句不管是否执行，只要返回while读取新行，都++；
    next if ($ln != $nu*4-2);   # 序列存在于4*$nu-2行，进行分析，否则next；
    $nu++;
    chomp $line;
    @ar=split ("", $line);
## 第二部分，逐个字符比对，加入列相关的统计结果 ##
$a[103]=0;$t[103]=0;            # 4个中间变量数组末位赋值，扩展数组；
$g[103]=0;$c[103]=0;            # 同时初始化所有变量；
$empty=0;
$n=0;                           # $n（列号@的index）作为列位置计数器；
foreach $ar(@ar) {              # 数组中所有元素的操作用foreach；
    if ($ar[$n] eq "A") {
        $a[$n] ++;}
    elsif ($ar[$n] eq "T") {
        $t[$n] ++;}
    elsif ($ar[$n] eq "G") {
        $g[$n] ++;}
    elsif ($ar[$n] eq "C") {
        $c[$n] ++;}
    else {$empty ++;}           # 除了4种碱基之外，可能出现空位；
    $n++;}
}
## 第三部分，以与列相关的变量为中介，统计最终的计数结果并打印 ##
$i=0;
while ($i<101) {
    $at[$i]=($a[$i]+$t[$i])/($a[$i]+$t[$i]+$g[$i]+$c[$i]);
    $gc[$i]=($g[$i]+$c[$i])/($a[$i]+$t[$i]+$g[$i]+$c[$i]);
    push (@out, "$a[$i]\t$c[$i]\t$g[$i]\t$t[$i]\t$at[$i]\t$gc[$i]\n");                # 将六个数值加入到@out下一行；
    $i++;}
print @out;                     # 打印显示@out数组；
