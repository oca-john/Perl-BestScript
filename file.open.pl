#!/usr/bin/perl
 
open(DATA, "<file.txt") or die "file.txt 文件无法打开, $!";
 
while(<DATA>){
   print "$_";
}
