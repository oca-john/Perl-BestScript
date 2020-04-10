# BioPerl-Installation-perlbrew

## 1.安装perlbrew
### a.在openSUSE上安装：
`sudo zypper in perl-App-perlbrew`, 使用openSUSE在线库中的perl应用安装perlbrew工具。

### b.在其他Linux上安装：
`curl -L https://install.perlbrew.pl | bash`, 从官网下载自动安装脚本，并安装perlbrew工具。

## 2.安装cpanm
### a.在openSUSE上安装：
`sudo zypper in perl-App-cpanminus`, 使用openSUSE在线库中的perl应用安装cpanm模块集。

### b.在其他Linux上安装：
`perlbrew install-cpanm`, 使用perlbrew安装cpanm模块。

## 3.安装BioPerl
`cpanm Bio::Perl`, 使用cpanm模块安装BioPerl模块。
