## 第二篇：构造一条fasta 序列
我们先来学习使用BioPerl 来构造fasta 序列。
用BioPerl 该怎么写：

```perl
#!/usr/bin/perl -w
use Bio::Seq; #加载Bio::Seq 模块。
$seq_obj = Bio::Seq->new; #调用Bio::Seq 模块的new 方法，可以建立一个序列对象，命名为$seq_obj。
#给这个新建的$seq_obj 对象赋予三个属性的值：dispaly_name（序列的名称），desc（序列的描述）以及seq（序列的内
容）
$seq_obj->display_name(“gi|147605|gb|J01673.1|ECORHO”);
$seq_obj->desc(“E.coli rho gene coding for transcription termination factor”);
$seq_obj->seq(“AACCCTAGCACTGCGCCGAAATATGGCATCCGTGGTATCCCGACTCTGCTGCTGTTCAAAAACGGTGAAG”);

# 第一句是模块的加载，会把相关的新函数（其实是“方法”）加载进来。
# 第二句的语法其实在小驼书中已提到过：调用了Bio::Seq 模块中的new 方法。对于调用面向对象的模块的方法（以前说“函数”，在OO 术语中称“方法”）要使用“全名”的方式来调用，语法是：
# 模块名（Bio::Seq）+瘦箭头（->）+方法名（new）。顺便透露一个小秘密：所有面向对象的模块都有一个叫做“new”的方法，它的功能简单且重要：创建一个新的对象。
```

你可能还会为两个问题而困惑：

1. 问：为什么要使用new函数来返回一个对象，而不是像创建标量那样直接写$seqobj就行了呢？ 答：因为对象是需要我们自定义的，所以我们需要写一个子程序来定义对象的结构（其实是它的属性和方法，只是空的白纸，还没有填入内容），而碰巧这个子程序的名称就叫new，并且别人已经帮我们写好且内嵌在Bio::Seq模块（以及以后我们要用的其他模块）里了。
2. 问：对象的名称一定要以obj结尾吗？ 答：不需要。你完全可以写` $seq = Bio::Seq->new; `，这样也是创建了一个名字叫做seq的对象，但是到后来你会搞不清$seq究竟是一个存放序列字符串的标量标量呢还是一个存放（指向）整个序列信息的对象呢？所以，既然对象没有”前缀“，我们就自己给它加一个“后缀”上去。 

创建了一个seq_obj对象之后，我们可以为它“赋值”。先来回顾一下其他数据结构是怎么赋值的：

```
   给标量赋值：  $scalar=”Hello!\n”;
   给列表赋值：  @array=(1, 2, 3, 4, 5);
   给哈希赋值：  %hash=(“key1″=>”vlaue1″, “key2″=>”value2″);
```

对象“赋值”的方式比较特殊。对于这个Bio::Seq（以及许多BioPerl对象）对象来说，是采取调用方法来“赋值”。

```perl
$seq_obj->display_name(“gi|147605|gb|J01673.1|ECORHO”);
$seq_obj->desc(“E.coli rho gene coding for transcription termination factor”);
$seq_obj->seq(“AACCCTAGCACTGCGCCGAAATATGGCATCCGTGGTATCCCGACTCTGCTGCTGTTCAAAAACGGTGAAG”); 
```

而且，和标量、数据、哈希一样，对象的创建和“赋值”可以合并为一步：

```perl
#!/usr/bin/perl -w
use Bio::Seq;
$seq_obj = Bio::Seq->new( -display_name => “gi|147605|gb|J01673.1|ECORHO”,
-desc => “E.coli rho gene coding for transcription termination factor”,
-seq => “AACCCTAGCACTGCGCCGAAATATGGCATCCGTGGTATCCCGACTCTGCTGCTGTTCAAAAACGGTGAAG”);
```

这个程序有点像哈希赋值，但“胖箭头”左边的“键”有点不同寻常，带了短横线。

我们来看看前面一大堆操作创建出来的$seqobj对象到底是怎样的。现在我们已经赋予了它三个属性：displayname, desc, seq，即所谓fasta序列的“三要素”：名称、描述和序列。赋予了这些“值”之后，我们可以查看它们，当然直接打印$seq_obj是行不通的（正如不能自己打印%hash一样），而是要通过调用“方法”来返回可打印的字符串：

```perl
my ($fasta_name,$fasta_desc,$fasta_seq); #创建了三个普通的标量变量来存放三个属性值
$fasta_name = $seq_obj->display_name; #调用对象的display_name方法来得到名称
$fasta_desc = $seq_obj->desc;         #调用对象的desc方法来得到描述
$fasta_seq = $seq_obj->seq;           #调用对象的seq方法来得到序列
#现在可以打印三个属性值了 
print “NAME:\t$fasta_name\nDESCRIBE:\t$fasta_desc\nSEQUENCE:\t$fasta_seq\n”;
```

结果将是这样：

```
NAME:    gi|147605|gb|J01673.1|ECORHO
DESCRIBE:    E.coli rho gene coding for transcription termination factor
SEQUENCE:    AACCCTAGCACTGCGCCGAAATATGGCATCCGTGGTATCCCGACTCTGCTGCTGTTCAAAAACGGTGAAG
```

对于这个$seq_obj对象，我们可以直接数出序列的长度：

```perl
$fasta_seq_length = $seq_obj->length;  # 得到序列的长度，70 
```

我们可以查阅这段序列究竟是DNA还是蛋白质。

```perl
$fasta_property = $seq_obj->alphabet;   # 返回dna，看来Perl猜对啦 
```



## 第三篇：从本地文件中获取fasta序列

在BioPerl中，我们是把一整条序列的“信息”存放到某个序列对象里（我喜欢写成$seq_obj），然后通过该对象的一些属性和方法来获取我们所需要的信息（而不是正则表达式，因为$seq_obj可不是字符串哦！）。

上一篇中，我们是自己敲打键盘把序列的信息输入到$seq_obj对象里面的，这样太麻烦了。既然现在fasta序列已经规规矩矩地排在文件里面了，有没有办法能直接把整条序列“输入”到$seq_obj里呢？有的。这个方法很特殊，它要借助另外一个模块生成的对象：Bio::SeqIO对象。

Bio::SeqIO模块可以打开、读取特定的序列文件，比如fasta文件，得到的结果是一个特殊的对象：SeqIO对象。它的属性和方法与之前提到的Seq对象不大一样。（说实话，关于对象的事情比较纠结：整个Perl世界中只有一种数组，一种哈希，看过小驼书的人都知道怎样操作数组、哈希；然而整个Perl世界中却有无数种对象，它们的操作方法没有统一的规则，只有自己去看模块说明文档）

首先我们要用use语句来加载需要用的模块：

```perl
use Bio::SeqIO;
use Bio::Seq;        #  透露个小秘密：其实这句话可以不写，因为SeqIO模块“包括”了Seq模块
```

注意大小写，不要写成Seqio了。

然后就可以创建一个SeqIO对象来读取文件（注意，SeqIO对象是用来读写文件使用的，而Seq对象是用来存放序列使用的，别混淆啦！），还记得上一篇提过的怎样创建一个新的对象吗？其实熟练了以后是很简单的哦：模块名（Bio::SeqIO）+瘦箭头（->）+方法名（new），上一篇也说过，所有面向对象的模块（Bio::Seq，Bio::SeqIO）都有一个叫做new的方法，它的功能简单而且重要：创建一个新的对象。在这里，我们直接把SeqIO对象的创建与“赋值”合而为一。那么怎样为SeqIO对象“赋值”呢？因为SeqIO对象是用来读取文件的（或写入文件，我们以后再说），所以你当然需要告诉Perl两件事：（1）你要读取的序列文件叫什么名字？然后把它“赋值”给-file！（2）你要读取的序列文件是什么格式？然后把它“赋值”给-format！

对于本例来说，我们要读取的序列文件叫做ecorho.fasta，文件格式是fasta，所以我们要创建SeqIO对象可以这么写：

```perl
$catchseq_seqio_obj = Bio::SeqIO->new(-file=>‘ecorho.fasta’, -format=>‘fasta’);   #  注意，现在“打开“文件不是写成 open 了！
```

我在这里创建的SeqIO对象的名字取得很复杂：$catchseq_seqio_obj，其实是有原因滴！后缀名seqio_obj表示这是一个SeqIO对象，以便于在后续调用中让自己易于识别（Perl本身并不需要为创建的对象取任何后缀名，但是我自己需要呵！），前面的名称catchseq意思是我创建的这个SeqIO对象是用来读取文件的。（因为SeqIO对象还有写入文件的作用，但语法有所不同。以后我们会遇到这样的问题：从一个大的序列文件中读取几条序列，再以另一种格式写入一个新的文件中，如果都叫做$seqio_obj，Perl不一定会混淆，但你自己肯定会混淆）   

好了，文件ecorho.fasta已被“打开”，怎样读取里面的内容呢？相信你现在应该已经熟悉BioPerl的思维（其实是面向对象的思维）了吧？我们不是希望像以前那样一行一行地读取文本字符串，而是希望把完整的一条fasta序列读进Seq对象里（就是上一篇常写的$seq_obj啦！）。方法是：调用刚刚建立的SeqIO对象的next_seq方法。

```perl
$seq_obj = $catchseq_seqio_obj->next_seq;   # next_seq方法将返回一个Seq类型的对象，这里写作$seq_obj
```

现在，这条fasta序列的各种信息都已经存在$seq_obj里了，于是我们就可以像上一篇那样通过调用Seq对象的方法来获得需要的信息。

```perl
$display_name = $seq_obj->display_name;      #  序列的名称 
$desc = $seq_obj->desc;                      #   序列的描述
$seq = $seq_obj->seq;                        #   序列字符串
$seq_type = $seq_obj->alphabet;              #   序列的类型（dna还是蛋白质？）
$seq_length = $seq_obj->length;              #   序列的长度 
#   再透露个小秘密，其实对象$seq_obj的属性和方法还很多呢。比如，你可以从里面截取一段序列，还可以求它的互补序列。所有的这些细节都不需要你自己计算，放心地写->就行了！
#   至于这些方法叫什么名字，你可以查看BioPerl网站的教程：初学者起步
```

你或许会认为：这样子操作好像与普通的方法相比简单不了多少。别急！我们现在在文件中只放了一条序列，如果有两条以上的序列，我们想分别取出他们的名称、长度等信息，这时你用常规方法就很麻烦了。但是使用BioPerl却相对要简单的多，其秘诀就在SeqIO对象的next_seq方法里。

#### 文件中有多条fasta序列，怎么办？

我们假设你在sequence.fasta里放了两条fasta序列。首先，还是老方法，“打开”这个文件（千万不要写open）。

```perl
$catchseq_seqio_obj = Bio::SeqIO->new(-file=>‘sequence.fasta’, -format=>‘fasta’);
```

然后，调用SeqIO对象的next_seq方法，你将得到第一条序列，可以把它放在$seq1_obj里：

```perl
$seq1_obj = $catchseq_seqio_obj->next_seq;  # 接下来可以提取它的各种信息了，序列名称、序列长度等
```

那么第二条序列怎么办呢？你可以再调用一次SeqIO对象的next_seq方法，这时它返回的将是第二条序列，可以把它放在$seq2_obj里：

```perl
$seq2_obj = $catchseq_seqio_obj->next_seq;  # 接下来可以提取它的各种信息了，序列名称、序列长度等
```

再往下，其实下面已经没有序列了。如果你的好奇心无可救药，可以再调用一次SeqIO对象的next_seq方法试试看：

```perl
$seq_obj = $catchseq_seqio_obj->next_seq;   #  因为下面没有序列了，所以返回来的是undef
```

所以，与其要不厌其烦的写$seq1_obj，$seq2_obj……不如来个while循环来得快捷：

```perl
while($seq_obj = $catchseq_seqio_obj->next_seq)
{
    #  在这儿处理每个序列的信息
    $display_name = $seq_obj->display_name; 
    #  以下省略
}
```

每次循环处理一条序列，多么简洁清晰！（当然你要把每次处理的结果保存起来，比如打印到表格里，不然下次循环不就覆盖了上次么？）不管两三条序列，还是成千上万条序列，都不怕了！

哦哦！这一讲就到这里为止啦。顺便再提一句，在进行这一讲的练习时，需要你自己先从诸如NCBI这样的网站上手动下载一些fasta序列的文本文件，再使用BioPerl来分析这些文本文件。事实上，BioPerl还可以作为一个下载工具从远程数据库下载序列文件。



## 第四篇：从本地文件中获取Genbank序列

#### 什么时候使用BioPerl？

例子一：小明、小王、小红的各科成绩。放在文件score.txt里（perl / awk）

```
name        math     English     computer
Xiaoming      90          84           91
Xiaowang      83          88           82
```

例子二：三条fasta序列。放在文件sequence.fasta里（bioperl）

```
>xiaoming
CGCTATTCAACAAGGCATTCCCCCAAGTTTGAATTCTTTGAAATAGATTGCTATTAGCTA
AGATAAGAACGAAAAGGAAGGATATGGCTAAAGAAACATCTGCAATGCTTTTATTAAAAA
>xiaowang
ACCTAGCGACTCTCTCCACCGTTTGACGAGGCCATTTACAAAAACATAACGAACGACAAT
```

第一个文件score.txt，每行的信息都是独立的（第1行：标题；第2行：小明成绩；第3行：小王成绩；……）：这样的文件很适合用Perl来处理（甚至连Perl程序都不用写，直接使用awk工具都行）。第二个文件sequence.fasta，不同行的信息却是有关联的（小明的在1~3行，小王的在4~5行，……）由于Perl只能一行一行地读入信息，就比较麻烦。

#### 如何从本地文件中提取Genbank序列？

差不多该问这个问题了。如果你已经熟记了前面两篇的内容，应该会依葫芦画瓢了（先到NCBI网站上下载一条Genbnak序列来联系吧！但要短一点的那种）。假设我们下载了一条Genbank序列保存在一个叫做ecorho.gbk 的文本文件里（扩展名不是必需的，我只是为了便于辩认），就能很快地写出如下代码：

```perl
use Bio::SeqIO;
$catch_seq = Bio::SeqIO -> new(-file => ‘ecorho.gbk’, -format => ‘genbank’);
$seq_obj = $catch_seq -> next_seq;
```

我在这里偷懒了一点：第二句代码中创建的SeqIO对象我直接写成$catch_seq，把后缀名seqio_obj省掉了。如果你一直不放心$catch_seq是什么的话，还是把后缀加上去比较好。也可以使用ref函数来检查一下$catch_seq究竟是什么。

```perl
ref($catch_seq);
```

在这个例子中该函数会返回Bio::SeqIO::genbank，所以说明$catch_seq是一个Bio::SeqIO类型的对象！如果$catch_seq只是一个普通的标量的话，不会有返回值。

可以接着往下说了，因为GenBank文件的信息很丰富，所以在绝大多数情况下从数据库中下载得到一个Genbank的文件一般都只有一条序列，所以我们还可以偷懒一些，把文件的读取和序列的读取合并起来：

```perl
$seq_obj = Bio::SeqIO -> new(-file => ‘ecorho.gbk’, -format => ‘genbank’) ->next_seq;
```

一行语句中出现两个瘦箭头，不习惯吧？但这确实是Perl高手们很习惯的写法。注意：如果一个文件中有多条序列，那是不能这么写的。请老老实实按照上一篇所给的格式写。

最后的问题是，-format参数该怎么写？读取fasta文件时我们写-format => ‘fasta’，读取Genbank文件时我们写-format => ‘genbank’，那么其它的格式呢？比如SwissProt格式，是不是写-format => ‘swissprot’呢？不是的，其实应该写成-format => ‘swiss’，关于Bio::SeqIO模块究竟支持哪些序列格式，以及格式的写法，请到http://www.bioperl.org/wiki/HOWTO:SeqIO看一看。

#### 如何获取序列的信息？

怎样从$seq_obj对象里把genbank序列的信息提取出来呢？我们还是依葫芦画瓢，照着上一篇提到的几项内容，代进去试试看：

```perl
$display_name = $seq_obj->display_name;    #  序列的名称 
$desc = $seq_obj->desc;                    #   序列的描述
$seq = $seq_obj->seq;                      #   序列字符串
$seq_type = $seq_obj->alphabet;            #   序列的类型（dna还是蛋白质？）
$seq_length = $seq_obj->length;            #   序列的长度
```

你就会愉快地发现它们都能返回一些有趣的信息，$seq_obj能调用的方法还有一些，在http://www.bioperl.org/wiki/HOWTO:Beginners的Table3中有详细的描述。

#### 处理多个Genbank文件

到目前位置我们使用Bio::SeqIO模块都是只读取一个序列文件。而有时我们经常想读取好几个Genbank文件，当然一个很简单的方法是先用某些Unix命令把要处理的一连串gbk文件都合并为一个，再进行操作就行了。比如可以使用Shell重定向来合并文件：

```perl
cat *.gbk >combine.gbk     #把当前目录下面所有的Genbank文件都合并到combine.gbk
```

当然对于没有相关命令可用的用户来说就太痛苦了。其实BioPerl也是可以读取多个文件的，只是模块要换一下，不是Bio::SeqIO了，改成Bio::SeqIO::MultiFile，

```perl
use Bio::SeqIO::MultiFile;
#  读取a.gbk和b.gbk两个文件
$catch_seq = Bio::SeqIO::MultiFile -> new(-files=>[‘a.gbk’,‘b.gbk’], -format=>‘genbank’);
while($seq_obj = $catch_seq -> next_seq)  {
     do sth…
}
```

或者这样：

```perl
use Bio::SeqIO::MultiFile;
#  读取当前目录下面所有后缀名为gbk的文件。
$catch_seq = Bio::SeqIO::MultiFile -> new(-files=>[glob “*.gbk”], -format=>‘genbank’);
while($seq_obj = $catch_seq -> next_seq)  {
     do sth…
}
```

语法和Bio::SeqIO很像，当然你应该写成-files而不是-file，把要处理的文件的列表传给-files就行了，别忘了加上中括号，因为列表是不能当成哈希的值的哦！引用才可以。

#### 从命令行中传入参数

如果我们想用前面的代码处理另一个Genbank文件（比如seq.gbk），我们必须打开源代码文件，把-file => ‘ecorho.gbk’ 改成 -file => ‘seq.gbk’，这样子太麻烦了。事实上这些要处理的文件的名字应该由用户来决定，而不是由你写在源代码里。有没有办法像“钻石操作符”（<>）那样通过命令行参数读入文件名呢？当然可以，而且还很简单，请看：

```perl
use Bio::SeqIO;
$filename = shift @ARGV;       #  从命令行中读取文件名,而不是写在程序里
$catch_seq = Bio::SeqIO -> new(-file => $filename, -format => ‘genbank’);
```

呵呵，这样子这几行代码就可以处理世界上所有的Genbank文件了，再也不需要修改源代码了。

如果想读取多个文件，也是可以的，稍微修改一下就行了，换汤不换药的。

```perl
use Bio::SeqIO::MultiFile;
@filenames = @ARGV;
$catch_seq = Bio::SeqIO::MultiFile -> new(-files => [@filenames], -format =>‘genbank’);
```



## 第五篇：序列格式的转换

我们先来试试把上一篇提过的那个ecorho.gbk序列转换为fasta格式，然后保存到文件ecorho.fasta里。首先老方法获取序列：

```perl
use Bio::SeqIO;
$catch_seq = Bio::SeqIO -> new(-file => ‘ecorho.gbk’, -format => ‘genbank’);
$seq_obj = $catch_seq -> next_seq;
```

现在这条Genbank序列已经放在对象$seq_obj里了。接下来要做的是如何把它写入新的文件中，而且是fasta格式。方法还是借助Bio::SeqIO模块。

```perl
$output_seq = Bio::SeqIO -> new(-file => ‘>ecorho.fasta’, -format => ‘fasta’);
```

和上面那一句实在是太像了！所不同的是文件名ecorho.fasta前面多了一个大于号！很熟悉吗？没错，这就是建立新文件，而且指明格式为fasta。然后我们就可以把$seq_obj这条序列“放到”新文件里面。调用的是对象$output_seq的write_seq方法。

```perl
$output_seq -> write_seq($seq_obj);  # 把序列 $seq_obj 写入新文件中
```

到此，序列转换就完毕了。打开新生成的ecorho.fasta看一下吧！

刚才只是提及一条复杂序列转换为一条简单序列，如果有多条序列要转换，并且希望都放到一个fasta文件中呢？比如，假设文件ecorho.gbk中有多条Genbank序列，都要把它们转换成fasta格式，并且保存在一个文件ecorho.fasta中，完整的程序就是这样：

```perl
use Bio::SeqIO;
$catch_seq = Bio::SeqIO->new(-file=>‘ecorho.gbk’,-format=>‘genbank’);
while($seq_obj = $catch_seq->next_seq)
{
    $output_seq = Bio::SeqIO->new(-file=>‘>>ecorho.fasta’,-format=>‘fasta’);
    $output_seq->write_seq($seq_obj);
}
```

不难吧？其实就是简简单单地把”>”符号换成了”>>”符号，表示应该是”追加文件”！

最后可能你还想问：Genbank能转换成fasta，那么fasta能不能转换成Genbank呢？简单地回答就是：理论上能，但没有必要。因为，无中生有难啊！

