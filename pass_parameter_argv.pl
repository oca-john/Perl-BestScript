#!/usr/bin/perl -w
# This script shows how to passing parameters into perl by @ARGV
# 20191231 by xi

# perl ps_pm_by_argv.pl passing_parameter_into_perl.pl
# 在perl解释器 perl脚本之后，直接跟待处理文件名，默认存入@ARGV环境变量
# 在程序内使用shift从@ARGV变量中取出，赋值给任意标量即可调用
$filename=shift @ARGV;
# 测试即可发现传入的参数已经被成功赋给标量
print "Your file is $filename, right?\n";
