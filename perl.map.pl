#!/usr/bin/perl -w
# This script shows how to passing parameters into perl by array
# 20200102 by xi

# map操作符其实跟grep的类似的用法，但是从概念上稍微有点不一样。grep可以认为是
# 筛选出符合条件的元素，不对元素对任何改变；而map则不一样，其可以将输入的元素
# 进行转化，然后再输出。map操作符也有分表达式和块形式两者。

#
my @result = map $_ + 1, @array;
