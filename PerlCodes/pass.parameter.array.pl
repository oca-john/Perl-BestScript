#!/usr/bin/perl -w
# This script shows how to passing parameters into perl by array
# 20191231 by xi

# 直接用$0捕获perl的0号参数，即接受的文件名
print "This is your input file named: $0\n";

# 提示输入用逗号分隔的参数列表
print "Please input you parameters one by one, and split with comma.\n";
# 用标量接收并转为数组
$inp=<STDIN>;
@in=split(",", $inp);
# 以数组脚标的形式调用参数内容
print "The parameter one is: $in[0]\nThe parameter two is: $in[1]\nThe parameter three is: $in[2]\n";
