# annovar.pl.man

## 1. cmd

table_annovar.pl path/to/vnf.input.file path/to/humandb/ -buildver hg19 -out xiannot -remove -protocol refGene,cytoBand,avsnp138,clinvar_20170905,cosmic70,dbnsfp30a,dbscsnv11,gnomad_exome,esp6500si_all,exac03,ljb2_sift -operation g,r,f,f,f,f,f,f,f,f,f -nastring . -vcfinput -polish
    

## 2. 相关的库以及属性

### 主要的库：

refGene g
cytoBand    r

### 筛过的：

1000g2015aug	f
avsnp138	f
clinvar_20170905	f
cosmic70	f
dbnsfp30a	f
dbscsnv11	f
esp6500si_all	f
exac03	f
gencode	g
gnomad_exome	f
gnomad_genome	f
ljb2_sift	f
snp142	f

OMIM    已注册-在审核
HGMD    已注册-未收到邮件


## 3. 参考文章

文章`ANNOVAR_Genomic variant annotation and prioritization with ANNOVAR`很有参考价值；

### 3.1 注释库下载示例：

perl annotate_variation.pl --downdb --buildver hg19 cytoBand humandb/
perl annotate_variation.pl --downdb --webfrom annovar --buildver hg19 1000g2014oct humandb/

### 3.2 注释语句示例：

perl table_annovar.pl <variant.vcf> humandb/ --outfile final –buildver hg19 --protocol refGene,cytoBand,1000g2014oct_eur,1000g2014oct_afr,exac03,ljb26_all,clinvar_20140929,snp138 --operation g,r,f,f,f,f,f,f --vcfinput
perl table_annovar.pl example/ex2.vcf humandb/ -buildver hg19 -out myanno -remove -protocol refGene,cytoBand,exac03,avsnp147,dbnsfp30a -operation g,r,f,f,f -nastring . -vcfinput -polish

- 3.2 基本说明了主要的注释库，以及主要的两个参数：

#### 3.2.1 protocol

    --protocol
    names of db

#### 3.2.2 operation

    --operation
    g   gene_based
    r   region_based
    f   filter_based
