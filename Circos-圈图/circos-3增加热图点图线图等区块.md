# circos-3增加热图点图线图等区块

CIRCOS图在有了染色体信息界定绘图区域后，就可以向里面添加离散数据如标记特定的区域或连续数据如展示修饰的丰度等。

经过前面部分对CIRCOS基本安装，最简单绘图和调整各部分属性的熟悉后，这些基本配置都可以写入单独的文件，供多次使用，就像下面主配置文件中的include所示。

而我们每次绘图主要修改的部分就在主配置文件里面，更换下对应圈的文件名、半径和绘制属性即可。

main circos configure 

(test.circos.conf)

```
<<include etc/colors_fonts_patterns.conf>>

# # 必须的部分，控制染色体信息显示
# # 之前两篇教程为了方便理解ideogram和ticks都是直接写在主配置文件的
# # 但通常实际使用时会拆分成不同文件，方便管理，所以这里采用了引用方式
# # 具体解释都见前面的文章
<<include ideogram.conf>>
<<include ticks.conf>>

# 定义输出
<image>
<<include etc/image.conf>>
file*=test.circos.png
dir*=./
</image>

# karyotype定义染色体的名字、ID、起始位置信息，是绘制图的根本
# 具体解释看前面2篇文章
karyotype = test.chromsomes.circos_input.txt

# `chromosome_units`定义染色体一个单位的大小，缩写为`u`。若`chromosome_units=1000000`, 
 则`10u=10000000`。
# 后面会用到这个单位，尤其是ticks中
chromosomes_units =1000000
chromosomes_display_default = yes

# 大标签highlights，复数定义里面有多个highlight
<highlights>

# 高亮的区域放在 <highlight>标签中，配置简单，给定文件名和内外半径就好
# 文件格式见下面解释
<highlight>
file=HL1.bed.circos_input.txt
r0=0.914285714286r
r1=0.991428571429r
</highlight>

# 高亮的区域放在 <highlight>标签中，配置简单，给定文件名和内外半径就好
# 文件格式见下面解释
<highlight>
file=HL2.bed.circos_input.txt
r0=0.828571428571r
r1=0.905714285714r
</highlight>

# 高亮的区域放在 <highlight>标签中，配置简单，给定文件名和内外半径就好
# 文件格式见下面解释
<highlight>
file=HL3.bed.circos_input.txt
r0=0.742857142857r
r1=0.82r
</highlight>

</highlights>

# 定义绘制的线图、点图、热图、直方图等，复数plots
<plots>

# 全局属性定义
color = spectral-7-div-rev
stroke_thickness = 1
stroke_color = black
scale_log_base = 0.5

# 其中一个子图，给定文件名，内外半径，和绘制类型
# 文件格式见下面解释
<plot>
file=Heatmap1.bed.circos_input.txt
type=line
r0=0.657142857143r
r1=0.734285714286r
</plot>

# 其中一个子图，给定文件名，内外半径，和绘制类型
# 文件格式见下面解释
<plot>
file=Heatmap2.bed.circos_input.txt
type=scatter
r0=0.571428571429r
r1=0.648571428571r
</plot>

# 其中一个子图，给定文件名，内外半径，和绘制类型
# 文件格式见下面解释
<plot>
file=Heatmap3.bed.circos_input.txt
type=histogram
r0=0.485714285714r
r1=0.562857142857r
</plot>

# 其中一个子图，给定文件名，内外半径，和绘制类型
# 文件格式见下面解释
<plot>
file=Heatmap4.bed.circos_input.txt
type=heatmap
r0=0.4r
r1=0.477142857143r
</plot>

</plots>

<<include etc/housekeeping.conf>>
max_points_per_track*  =  2500000
data_out_of_range* = trim
```

下面看下文件格式的要求

test.chromsomes.circos_input.txt

```
##chr - ID LABEL START END COLOR
chr - chr1 hs1 0 248956422 chr1
chr - chr2 hs2 0 242193529 chr2
chr - chr3 hs3 0 198295559 chr3
chr - chr4 hs4 0 190214555 chr4
chr - chr5 hs5 0 181538259 chr5
```

高亮文件的格式一致，选其中一个做例子 HL1.bed.circos_input.txt

```
#ParentID    START    END    ATTRIBUTE
#ParentID对应于karyotype文件的ID（第3列)
#ATTRIBUTE列颜色的获取看前面两篇的介绍以获知有多少可用颜色
chr1 0 6422000 fill_color=vlyellow
chr1 12447822 24895644 fill_color=vlpred
chr1 136926042 149373864 fill_color=vlppurple
chr1 236508618 248956422 fill_color=vlporange
chr2 0 2421000 fill_color=vlpred
chr2 36329031 48438708 fill_color=vlpgreen
chr2 193754832 205864509 fill_color=vlpred
chr2 133206447 145316124 fill_color=vlyellow
chr3 59488668 69403446 fill_color=vlpred
chr3 128892114 138806892 fill_color=vlpblue
chr3 1800000 198295559 fill_color=vlpred
chr4 0 2145550 fill_color=vlpgreen
chr4 95107280 104618008 fill_color=vlpblue
chr4 133150192 142660920 fill_color=vlppurple
chr4 190000000 190214555 fill_color=vlpgreen
chr5 0 1538259 fill_color=vlpblue
chr5 27230739 36307652 fill_color=vvlpgreen
chr5 72615304 81692217 fill_color=vvlyellow
chr5 127076782 136153695 fill_color=vvlporange
chr5 15382590 15392590 fill_color=vlpblue
```

数值文件格式也一致，只是给定不同的type绘制不同属性的图，如线图、热图等。

Heatmap1.bed.circos_input.txt

```
#ParentID    START    END    Value
#ParentID对应于karyotype文件的ID (第3列)
#Value列为我们想展示的值
chr1 0 12447822 1
chr1 12447822 24895644 2
chr1 211612974 224060796 18
chr1 224060796 236508618 19
chr1 236508618 248956422 20
chr2 0 12109677 1
chr2 12109677 24219354 2
chr2 24219354 36329031 3
chr2 36329031 48438708 4
chr2 48438708 60548385 5
chr2 205864509 217974186 18
chr2 217974186 230083863 19
chr2 230083863 242193529 20
chr3 0 9914778 1
chr3 9914778 19829556 2
chr3 19829556 29744334 3
chr3 29744334 39659112 4
chr3 39659112 49573890 5
chr4 0 9510728 1
chr4 9510728 19021456 2
chr4 19021456 28532184 3
chr4 28532184 38042912 4
chr4 133150192 142660920 15
chr4 171193104 180703832 19
chr4 180703832 190214555 20
chr5 0 9076913 1
chr5 9076913 18153826 2
chr5 18153826 27230739 3
chr5 154307521 163384434 18
chr5 163384434 172461347 19
chr5 172461347 181538259 20
```

所有文件都准备好之后，运行circos -conf test.circos.conf就可以获得test.circos.svg和test.circos.png两幅图了。

