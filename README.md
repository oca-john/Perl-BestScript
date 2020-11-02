# Perl.lang-xi

Perl 作为个人入门编程的第一门计算机语言，这里是所有 Perl 脚本和教程的集散中心。

## 1. 开发环境说明
Perl 开发需要 Perl 本身和相关三方库作为后端；

Terminal 类的操作环境作为运行窗口；

一个 TextEditor 作为编辑窗口。

## 2. Perl 调用外部程序
a. 单引号方式
```
`echo you are great`
```
b. system 函数
```
system("echo you are great")
```

## 3. Perl的生物学库 BioPerl
- BioPerl 通过 cpanm（perlbrew）安装比较方便
- 也可参考官方指南的操作安装

## 4. Perl 衍生程序最有名的是 Circos
- Circos 用于全基因组绘图；
- openSUSE 配置最为方便，使用 YaST 补充 GD 库即可；Kubuntu 稳定内核的可以使用，自带的 Muon 包管理器完全可替代新立得，安装 GD 库没问题；Ubuntu 以及 CentOS 的配置需要参考 circos 官网的 GD 安装说明（或参考Circos 圈图文件夹下的 Circos-两种安装方式-ZHXI.md），安装较旧的版本；
- Windows 下使用 StrawberryPerl 默认安装了所有相关库，但是调用方式奇怪，尚未运行成功；
