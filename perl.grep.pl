#!/usr/bin/perl -w
# This script shows how to passing parameters into perl by array
# 20200102 by xi

# grep 操作符可按照条件（大小，正则式）筛选列表中的所有元素，并将满足条件的元素赋值给新列表。

# 取出@array中大于2的元素
my @result = grep {$_ >3} @array;       # 带{}写法，grep + 条件 + 筛选对象
my @result = grep $_ >3, @array;        # 不带{}写法

# 单行命令测试
perl -e '@a=(1,3,5,2,4,9); @res=grep{$_>3} @a; print @res,"\n";'  # grep筛选大于3的元素打印

# 可以使用正则表达式，如从@input数组中取出1开头的数字
my @out = grep /^1/, @input;            # 搭配正则式，匹配以1开头的行

# 可以嵌入代码块，如筛选%hash中键值能被2整除的项
my @result = grep {
    my $in = $hash{$_};                 # 键值取出为某标量
    $in % 2;                            # 判断能否被2整除
} @array

# 上述代码展开等同于：
my @result = grep {
    my $in = $hash{$_};
    if ($in % 2) {
        1;
    }else{
        0;
    }
} @array

# 常见的去除重复元素的例子
my @uniq = grep {++$count{$_} < 2} @array;  # 筛选元素，并且计数限制为<2，即任何元素只计数1次
