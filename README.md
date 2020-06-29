# Perl.lang-xi
Perl作为个人入门编程的第一门计算机语言，这里是所有Perl脚本和教程的集散中心。

## 1. Perl 调用外部程序
a.单引号方式
```
`echo you are great`
```
b.system函数
```
system("echo you are great")
```

## 2. Perl的生物学库BioPerl
- BioPerl通过cpanm（perlbrew）安装比较方便
- 也可参考官方指南的操作安装

## 3. Perl 衍生程序最有名的是Circos
- Circos用于全基因组绘图；
- openSUSE配置最为方便，使用YaST补充GD库即可；Kubuntu稳定内核的可以使用，自带的Muon包管理器完全可替代新立得，安装GD库没问题；Ubuntu以及CentOS的配置需要参考circos官网的GD安装说明（或参考Circos圈图文件夹下的Circos-两种安装方式-ZHXI.md），安装较旧的版本；
- Windows下使用StrawberryPerl默认安装了所有相关库，但是调用方式奇怪，尚未运行成功；
