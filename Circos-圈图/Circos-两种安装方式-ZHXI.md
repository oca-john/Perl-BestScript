# Circos-两种安装方式-ZHXI
部分参考Circos官方说明文档

## Part I, easy work of install the circos

> For using the circos, you should be able to install the circos itself and other modules by yourself, **except the GD module**.  
> And I will introduct this at Part I in a simple word.  
> And I will show you how to install **GD module at Part II**.  

### 1.1 Download & tar the package

> Download the circos package from **circos.ca**  

``` sh
> tar -xvf circos-xx.tar.gz
```

### 1.2 Go into the bin directory & check the modules

``` sh
> cd circos-xx/bin/
> ./circos -modules
```

### 1.3 Install all the list modules by **`sudo cpan install xxx`**

> You should have cpan installed in you system  
> Try to type all these packages in one command, **`sudo cpan isntall all.the.packages.name`**  
> Some will be succeed.  

### 1.4 For some special modules, install them one by one under the root permission

> For some modules, you **must install them with `su`**  
> But if you install them at one time, there will be some mistakes.  
> Thus, it's better to install them one by one.  

## Part II, installing libpng, freetype, libgd and GD

**NOTICE: This Part Is Refferenced From The Homepage Of Circos.ca**

> Under linux, all my troubles about circos is just about Perl's GD module, which is the interface to the libgd system graphics library, except opensuse (for opensuse has it's powerful tool named yast).

> On **opensuse**, open the **yast** (both gui mode and text mode is ok), and type "libgd" into the search blank. The right panel will show you the results, choose the related packages and install, circos will be ok!

> When I use **centos**, it's really a trouble. The installation process is not robust because of dependencies and the possibility of their being different versions of these dependencies on your system. All the commands below is under centos 7.

### 1.1 Tar & compile the libpng, jpegsrc, freetype

> In this part, when compiling, you'd better to use the root permission.  
> Especially, **`sudo make install`**  
> You should notice at each **-prefix option**  

``` sh
> tar xvfz libpng-1.6.14.tar.gz     [http://circos.ca/distribution/lib/libpng-1.6.14.tar.gz]
> cd libpng-1.6.14
> ./configure —prefix=/usr/local
> make
> make install
```

``` sh
> tar xvfz jpegsrc.v9.tar.gz        [http://circos.ca/distribution/lib/jpegsrc.v9.tar.gz]
> cd jpeg-9
> ./configure —prefix=/usr/local
> make
> make install
```

``` sh
> tar xvfz freetype-2.4.0.tar.gz        [http://circos.ca/distribution/lib/freetype-2.4.0.tar.gz]
> cd freetype-2.4.0
> ./configure —prefix=/usr/local
> make
> make install
```

### 1.2 Generated files of compile

> You should now have libraries in **/usr/local/lib**  
> You can check them with **`ll /usr/local/lib`**  

```
-rwxr-xr-x  1 root  wheel   650336 21 Nov 11:15 libfreetype.6.dylib
-rw-r--r--  1 root  wheel  3676456 21 Nov 11:15 libfreetype.a
lrwxr-xr-x  1 root  wheel       19 21 Nov 11:15 libfreetype.dylib -> libfreetype.6.dylib
-rwxr-xr-x  1 root  wheel      957 21 Nov 11:15 libfreetype.la
-rwxr-xr-x  1 root  wheel   275736 21 Nov 11:14 libjpeg.9.dylib
-rw-r--r--  1 root  wheel  1492952 21 Nov 11:14 libjpeg.a
lrwxr-xr-x  1 root  wheel       15 21 Nov 11:14 libjpeg.dylib -> libjpeg.9.dylib
-rwxr-xr-x  1 root  wheel      920 21 Nov 11:14 libjpeg.la
lrwxr-xr-x  1 root  wheel       10 21 Nov 11:13 libpng.a -> libpng16.a
lrwxr-xr-x  1 root  wheel       14 21 Nov 11:13 libpng.dylib -> libpng16.dylib
lrwxr-xr-x  1 root  wheel       11 21 Nov 11:13 libpng.la -> libpng16.la
-rwxr-xr-x  1 root  wheel   240580 21 Nov 11:13 libpng16.16.dylib
-rw-r--r--  1 root  wheel  1077240 21 Nov 11:13 libpng16.a
lrwxr-xr-x  1 root  wheel       17 21 Nov 11:13 libpng16.dylib -> libpng16.16.dylib
-rwxr-xr-x  1 root  wheel      924 21 Nov 11:13 libpng16.la
drwxr-xr-x  6 root  wheel      204 21 Nov 11:15 pkgconfig/
```

### 2.1 Tar & compile the libgd

> Now install libgd, linking to the libraries installed above.  
> You should notice at the **`-prefix option below`**  

``` sh
> tar xvfz libgd-2.1.0.tar.gz       [http://circos.ca/distribution/lib/libgd-2.1.0.tar.gz]
> cd libgd-2.1.0
> ./configure --with-png=/usr/local --with-freetype=/usr/local --with-jpeg=/usr/local —prefix=/usr/local
```

>  Configuration summary for libgd 2.1.0:

```
   Support for Zlib:                 yes
   Support for PNG library:          yes
   Support for JPEG library:         yes
   Support for VPX library:          no
   Support for TIFF library:         no
   Support for Freetype 2.x library: yes
   Support for Fontconfig library:   no
   Support for Xpm library:          no
   Support for pthreads:             yes
```

### 2.2 Continue to compile libgd

``` sh
> make
> make install
```

> Results:

> You now have libgd in **`/usr/local/lib`**  

```
-rwxr-xr-x  1 root  wheel   389372 19 Nov 14:47 libgd.3.dylib
-rw-r--r--  1 root  wheel  1217200 19 Nov 14:47 libgd.a
lrwxr-xr-x  1 root  wheel       13 19 Nov 14:47 libgd.dylib -> libgd.3.dylib
-rwxr-xr-x  1 root  wheel     1139 19 Nov 14:47 libgd.la
```

> as well as some binaries in /usr/local/bin. In particular, you have /usr/local/bin/glib-config, which provides the configuration for your libgd installation

> The --with-* parameters during the configure stage of gdlib installation sets the sources of the dependencies that will be build into gdlib. If you used a different -prefix in compiling these dependencies (see above), adjust these parameters accordingly.  

> For example, if you compiled libpng with -prefix=/my/path then use --with-png=/my/path/.

### 2.3 Check all information of libgd

``` sh
> /usr/local/bin/gdlib-config —all
```
> Results:
```
GD library  2.1.0
includedir: /usr/local/include
cflags:     -I/usr/local/include
ldflags:     -L/usr/local/lib
libs:       -ljpeg -lz  -L/usr/local/lib -lpng16 -L/usr/local/lib -lfreetype -lz -liconv
libdir:     /usr/local/lib
features:   GD_JPEG GD_FREETYPE GD_PNG GD_GIF GD_GIFANIM GD_OPENPOLYGON
```

> You must have GD_FREETYPE and GD_PNG for Circos to run. The other features, such as support for JPEG and TIFF are optional. In this example, I’ve included the JPEG library in the installation.

### 3.1 Install the GD module

> Now, install the Perl interface to libgd — the GD module.  

``` sh
> tar xvfz GD-2.53.tar.gz       [http://circos.ca/distribution/lib/GD-2.53.tar.gz]
> perl Makefile.PL
```

> Configuring for libgd version 2.1.0.  
> Checking for stray libgd header files...none found.  
>  Compile result:  

``` sh
Included Features:          GD_JPEG GD_FREETYPE GD_PNG GD_GIF GD_GIFANIM GD_OPENPOLYGON
GD library used from:       /usr/local
Checking if your kit is complete...
Looks good
Writing Makefile for GD
Writing MYMETA.yml and MYMETA.json
```

> During the installation GD will look for libgd-config (see above) for libgd configuration. 

### 3.2 Continue to compile & test the version of GD module

``` sh
> make
> make install

> perl -MGD -e 'print $GD::VERSION,”\n”’
> 2.53
```

### 3.3 Check the GD module with `./circos -modules`

> Test that the modules are installed using

```
> cd /circos/bin/
> ./circos -modules
...
ok       0.39 Font::TTF::Font
ok       2.53 GD
ok        0.2 GD::Polyline
ok       2.39 Getopt::Long
ok       1.16 IO::File
...
```
