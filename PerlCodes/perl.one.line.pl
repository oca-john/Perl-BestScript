#!/usr/bin/perl
## perl one line

# 基本格式：
perl -parameter 'commands' inputfile

# -e 执行命令，也就是脚本	        # 必须有的参数
# -p 自动循环+输出，也就是while(<>){命令（脚本）; print;}
# -l 对输入的内容进行自动chomp，对输出的内容自动加换行符
# -n 相当于while(<>)

perl -pe 's/aaa/AAA/g' tst.txt	# -pe参数用于逐行读取度、处理、输出，即对每行处理
perl -ne '/regex/ && print'     # 打印匹配上的行
perl -ne 'print if /^\d+$/'		  # 灵活使用正则式，匹配纯数字的行并打印

perl -MList::Util=sum -alne 'print sum @F'	# 调用模块的sum函数
