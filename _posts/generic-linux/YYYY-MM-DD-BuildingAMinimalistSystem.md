---
layout: post
title: Building a Minimalist system
category: generic-linux
tags: [minimal, kernel, building, system]
author: [wei2912, Subsentient]

status: draft

sources: ["http://www.linuxfromscratch.org/", "https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard", "https://en.wikipedia.org/wiki/GNU_package#Base_system.5Bcitation_needed.5D"]

summary: A minimalist system is a tiny system which can be used for servers. Usually many people use a pre-built system like Debian, Red Hat and many others. Today, we're going to teach you how to build a much tinier system!

COMMENTS: EXPLAIN THE PACKAGES USED AND ADD IN COMPILATION OF SYSVINIT.

location: _posts/generic-linux/YYYY-MM-DD-BuildingAMinimalistSystem.md
---

Now, let's start off with the building of a minimalist system! For the simplicity of this tutorial, we're not going to teach you how to cross compile. It takes a lot of work to get a cross compiled system working.

Remember not to delete the source directories + the patches you use.

## Getting a partition ready for the system

First, get a free partition ready. I advise you use gparted. Format the partition as ext4 (or ext3/ext2).

Now, we will set up our partition. We'll mount our partition as "minsystem". Change the drive mounted and the filesystem type accordingly.

    mkdir /mnt/minsystem
    mount -v -t extX /dev/XXX /mnt/minsystem

Replace X accordingly.

Alternatively you can simply create a folder and put everything there.

Now, let's set up some variables. Have a source folder and a dependencies folder (required to compile but not run).

    export SOURCE="/path/here"
    export DEPEND="/path/here"
    export SYSTEM="/mnt/minsystem"
    
If you're putting everything in a folder, change SYSTEM to the path.

<!--more-->

## Getting the file hierachy ready.

We're going to use the FHS ([Filesystem Hierachy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)) standard.
    
    cd $SYSTEM
    mkdir bin boot dev etc home lib media mnt opt proc root sbin srv tmp usr var
    cd $SYSTEM/etc
    mkdir opt sgml xml
    cd $SYSTEM/usr
    mkdir bin include lib local sbin share src
    cd $SYSTEM/share
    mkdir doc
    cd $SYSTEM/var
    mkdir cache lib lock log mail run spool tmp
    cd $SYSTEM/var/spool
    mkdir mail

And if you want some nifty *mnt* directories...

    cd $SYSTEM/mnt
    mkdir disk{0..9}
    mkdir loop{0..9}
    mkdir iso{0..9}

## List of packages we're building

Download these files first before you continue. This will make your life much easier.

- [Linux Kernel](http://kernel.org). The kernel config can be obtained at [KernelDotConfig-ob_2.0.i586](/files/KernelDotConfig-ob_2.0.i586) kindly by Subsentient. For desktop config, you can give [KDotConfig-SubLinux-12-06-2012](/files/KDotConfig-SubLinux-12-06-2012) a try, also by Subsentient.
- [glibc (GNU C library)](http://www.gnu.org/software/libc/download.html)
- [Busybox](http://busybox.net/)
- [GNU ncurses](https://www.gnu.org/software/ncurses/ncurses.html)
- [GNU Bash](https://www.gnu.org/software/bash/)
- [e2fsprogs](http://e2fsprogs.sourceforge.net/)
- [GNU gcc](https://www.gnu.org/software/gcc/) and [GNU binutils](https://www.gnu.org/software/binutils/)
- [GNU coreutils](https://www.gnu.org/software/coreutils/)
- [util-linux](https://www.kernel.org/pub/linux/utils/util-linux/)
- [udev](http://www.freedesktop.org/software/systemd/libudev/)
- [GNU gawk](https://www.gnu.org/software/gawk/)
- [GNU less](https://www.gnu.org/software/less/)
- [GNU grep](https://www.gnu.org/software/grep/)
- [GNU patch](https://savannah.gnu.org/projects/patch/)
- [GNU groff](https://www.gnu.org/software/groff/)
- [man](http://primates.ximian.com/~flucifredi/man/) and [man-pages](https://www.kernel.org/doc/man-pages/)

## Building the kernel

Let's reenter the SOURCE directory.

    cd $SOURCE

(Screen resolutions may not be correct if you use this config, beware)

Choose a kernel you like (stable kernels if you want a stable system, experimental ones if you want to test out the latest and greatest). In this tutorial I will use 

Now, extract the kernel file to whatever directory you want. I advise you to use a directory in your home directory.

    tar xvf linux-*.tar.*

Now, copy the config over. Assuming the config is in the same directory as the archive:

    cp ./KernelDotConfig-ob_2.0.i586 ./linux-*/.config

Afterwards, enter the extracted archive

    cd ./linux-*

Configure the kernel and make it. BE SURE TO NOT ENABLE ANY MODULES.

(write about dependencies of menuconfig)

    make menuconfig
    make -j4

Once you got it make-ed, it's time to copy it to your minimalist system.

NOTE: If you have a BIOS that loads raw, uncompressed ELF executables, do this instead:

    cp ./arch/x86/boot/bzImage $SYSTEM/boot/vmlinux

For 32bit:

    cp ./arch/x86/boot/bzImage $SYSTEM/boot/vmlinuz

For 64bit:

    cp ./arch/x86-64/boot/bzImage $SYSTEM/boot/vmlinuz

Copy over the config.

    cp ./.config $SYSTEM/boot/config-versionhere-prefixhere
    
Change the prefix accordingly.

If you have any modules, use this command:

    make modules
    make modules_install INSTALL_MOD_PATH=$SYSTEM

End off with the headers.

    make headers_install INSTALL_HDR_PATH=$SYSTEM/usr/include
    
This could be a bug, but some things aren't copied over. Copy the rest over.

    cp -r include/* $SYSTEM/usr/include 

You're done!

## Building glibc (GNU C Library)

We need to build glibc, the library that is required for all Linux programs. This is very crucial to your system as it is the library that offers access to many commonly used header files. Then, extract the archive.

Extract the archive,

    tar xvf glibc-*.tar.*

Type these commands:

    mkdir glibc-build
    cd glibc-build
    ../glibc-*/configure --prefix=/usr --disable-profile -without-selinux --enable-add-ons --libexecdir=/usr/bin

--disable-profile disables profile support for glibc. --without-selinux also disables selinux support. --enable-add-ons tells glibc to use the NPTL add-on as its threading library.

Make it:

    make -j4

Don't expect it to finish fast.

Once you're done, install it:

    make install DESTDIR=$SYSTEM

You'll also need to install it to your system itself. Make sure not to install it directly.

    make install DESTDIR=~/NewGlibc

Now, copy everything from NewGlibc into your system.

    cd ~/NewGlibc
    cp -rf ~/NewGlibc/* /

If something goes wrong with your system, don't worry. Enter an external system and copy the files inside that directory to your system once more. It should boot up fine.
    
## Building busybox

Busybox provides many of the commands you see in a Linux system. You might want to change that by installing those tools from GNU into the system after you're done with the base.

Now, let's extract the archive.

    tar xvf busybox-*.tar.*

You'll need to apply a patch for 1.20.2. Download [busybox-1.20.2-sys-resource.patch](http://busybox.net/downloads/fixes-1.20.2/busybox-1.20.2-sys-resource.patch) to the busybox directory and use this command:

    cd busybox-*
    patch -Np1 -i *.patch

Configure it just like the kernel.

    make menuconfig

In Busybox Settings -> General Config, make sure to check "Don't use /usr". Also make sure that inetd is disabled.

Give it a build.

    make -j4

Now run this in a normal user account and not root.

    make install

This'll install everything to _install. Copy its contents to the system.

    cd _install
    cp -rf ./* $SYSTEM

## Building ncurses

ncurses is required for the graphical CLI things you see. It looks like the "make menuconfig" command in the kernel and busybox. Bash requires the library and thus we must compile ncurses first before we compile Bash.

Extract the archive and enter it.

    tar xvf ncurses-*.tar.*
    cd ncurses-*

Give it a configure as usual.

    ./configure --prefix=/usr --with-shared --enable-widec

--with-shared enables ncurses to use shared libraries. --enable-widec causes wide-character libraries to be built instead of normal libraries. They can be used in both multibyte and traditional 8-bit locales, while normal libraries can only be used in 8-bit locales. (thanks [LFS](http://www.linuxfromscratch.org/lfs/view/jh/chapter06/ncurses.html)!)

Make it.

    make -j4

Give it an install.

    make install DESTDIR=$SYSTEM

Now, create a couple of symlinks.

    ln -s $SYSTEM/usr/lib/libncursesw.so.5.9 $SYSTEM/usr/lib/libncurses.so.5.9
    ln -s $SYSTEM/usr/lib/libncurses.so.5.9 $SYSTEM/usr/lib/libncurses.so.5
    ln -s $SYSTEM/usr/lib/libncurses.so.5 $SYSTEM/usr/lib/libncurses.so

## Building bash

Bash is the Bourne Again SHell. What's a shell? Take a look at [Wikipedia's page about shells](https://en.wikipedia.org/wiki/Shell_(computing)). As Wikipedia says:

> A shell is software that provides an interface for users of an operating system which provides access to the services of a kernel.

You can see that it's really crucial for our system.

Extract the archive and enter it.

    tar xvf bash-*.tar.gz
    cd bash-*

Give it a configure as usual.

    ./configure --prefix=/usr

Build it and install it.

    make -j4
    make install DESTDIR=$SYSTEM

## Chrooting in for the first time

We're going to chroot (change the root filesystem) to our new system!

    chroot $SYSTEM

You should see no errors.

You'll notice that many commands appear to be missing. Do this:

    export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin

You've just added the 6 paths which contain binaries. Many commands will then be avaliable.

If all works fine, great. Exit.

    exit

## Building e2fsprogs

e2fsprogs is a set of utilties for maintaing ext filesystems, such as ext2, ext3 and ext4.

Extract the archive.

    tar xvf e2fsprogs-*.tar.*

Create a seperate build directory.

    mkdir e2fsprogs-build
    cd e2fsprogs-build

Let's configure it.

    ../e2fsprogs-*/configure --prefix=/usr --with-root-prefix="" --enable-elf-shlibs --disable-libblkid --disable-libuuid --disable-uuidd --disable-fsck

Certain programs inside e2fsprogs are considered as essential. If /usr is not mounted it must still be avaliable. They'll be in /lib and /sbin. If --with-root-prefix isn't passed to e2fsprogs everything will install in /usr, which is not good. 

--enable-elf-shlibs enables shared libraries. 

--disable-* disables the utilties that we already have.

Now, build it.

    make -j4
    make install DESTDIR=$SYSTEM
    
## Building gcc

GCC is a compiler by GNU. It's crucial to compiling applications.

### Binutils

You need to install Binutils first. Grab it at [http://ftp.gnu.org/gnu/binutils/](http://ftp.gnu.org/gnu/binutils/) and extract the archive.

    tar xvf binutils-*.tar.*
    cd binutils-*

Build it.

    ./configure --prefix=/usr
    make -j4
    make install

And install it to our system too.

    make install DESTDIR=$SYSTEM

### GCC

Extract the archive for gcc. You can get it at [http://ftp.gnu.org/gnu/gcc/](http://ftp.gnu.org/gnu/gcc/).

    tar xvf gcc-*.tar.*

Enter the gcc directory and download the prerequisites.

    cd gcc-*
    ./contrib/download_prerequisites

Create a seperate build directory.

    mkdir gcc-build
    cd gcc-build

Configure it.

    ../gcc-*/configure --prefix=/usr --enable-languages=c,c++ --without-headers --with-newlib

--enable-languages=c,c++ ensures that we compile gcc only for C and C++.

Build it.

    make -j4

Now, install it to the system.

    make install DESTDIR=$SYSTEM

## coreutils

We're going to grab coreutils. It contains the core utilties of the GNU Operating System (yes, it's by GNU). Get it at [http://www.gnu.org/software/coreutils/](http://www.gnu.org/software/coreutils/). We'll also grab a couple of dependencies.

### Dependencies to compile

You'll need [GMP](http://gmplib.org/).

Download them to $DEPEND. Now, extract them.

    cd $DEPEND
    tar xvf gmp-*.tar.*

    cd gmp-*
    ./configure --prefix=/usr
    make -j4
    make install

### Dependencies to run

You'll need [libcap](http://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/).

    cd $SOURCE
    tar xvf libcap-*.tar.*
    
    cd libcap-*
    ./configure --prefix=/usr
    make -j4
    make install DESTDIR=$SYSTEM

### Installation

Extract the coreutils archive and enter it.

    tar xvf coreutils-*.tar.*
    cd coreutils-*
    
Configure, build and install.

    ./configure --prefix=/usr --bindir=/bin --sbindir=/sbin
    make -j4
    make install DESTDIR=$SYSTEM

## util-linux

We're also going to grab util-linux. It's a couple of random utilities for Linux. You can get it at [https://www.kernel.org/pub/linux/utils/util-linux/](https://www.kernel.org/pub/linux/utils/util-linux/). 

### Dependencies

You need to get [zlib](http://www.zlib.net/). Download it to the $DEPEND directory and extract it.

    cd $DEPEND
    tar xvf zlib-*.tar.*
    cd zlib-*
    
    ./configure --prefix=/usr
    make -j4
    make install

### Installation

Extract the archive of util-linux.

    cd $SOURCE
    tar xvf util-linux-*.tar.*
    cd util-linux-*

Configure, build and install.

    ./configure --prefix=/usr --bindir=/bin --sbindir=/sbin --without-selinux --disable-su --disable-sulogin --disable-login
    make -j4
    make install DESTDIR=$SYSTEM
    
--without-selinux disables selinux support.

--disable-su, --disable-sulogin and --disable-login disable these utilties as we don't have PAM. We'll install those utilities later.

## udev

You can get udev from [http://www.kernel.org/pub/linux/utils/kernel/hotplug/](http://www.kernel.org/pub/linux/utils/kernel/hotplug/). Extract and build.

    tar xvf udev-*.tar.*
    cd udev-*
    ./configure --prefix=/usr
    make -j4
    make install DESTDIR=$SYSTEM

## Init

Now, you should make a choice between sysvinit and upstart or simply write a script to replace /sbin/init.

### Upstart

#### Dependencies

You'll need libnih first. Grab it from [https://code.launchpad.net/libnih](https://code.launchpad.net/libnih).

    tar xvf libnih-*.tar.*
    cd libnih-*
    
    ./configure --prefix=/usr
    make -j4
    make install DESTDIR=$SYSTEM
    
And for compilation of upstart to work:

    make install
    
You'll need dbus too. Get it from [http://www.freedesktop.org/wiki/Software/dbus](http://www.freedesktop.org/wiki/Software/dbus).

    tar xvf dbus-*.tar.*
    cd dbus-*
    
    ./configure --prefix=/usr
    make -j4
    make install DESTDIR=$SYSTEM
    
json-c (libjson) is another required dependency. Get it from [https://github.com/json-c/json-c/downloads](https://github.com/json-c/json-c/downloads).

    tar xvf json-*.tar.*
    cd json-*
    
    ./configure --prefix=/usr
    make -j4
    make install DESTDIR=$SYSTEM

#### Compiling

Grab it from [http://upstart.ubuntu.com/download.html](http://upstart.ubuntu.com/download.html). Extract the archive.

    tar xvf upstart-*.tar.*
    cd upstart-*
    
Now, configure and build it.

    ./configure --prefix=/usr --bindir=/bin --sbindir=/sbin --sysconfdir=/etc
    make -j4
    make install DESTDIR=$SYSTEM

### Sysvinit

<<< placeholder here >>>

### Script

If you're going to write a script, congrats! Your life would probably be easier.

Before you think this is a dirty hack, be noted that init can be anything you want and is simply runned at bootup time.

<<< placeholder here >>>

## Building better alternatives to BusyBox commands

Loads of BusyBox commands are not by GNU. They're BusyBox versions (obviously). Due to this, there might be inconsistency. This section addresses these concerns.

### GNU gawk

[GNU gawk](https://www.gnu.org/software/gawk/) is GNU awk. The BusyBox implementation of awk is not as useful, thus we're going to replace it.

Grab it from the link above and extract the archive:

    tar xvf gawk-*.tar.*
    cd gawk-*
    
Build and install.

    ./configure --prefix=/usr --bindir=/bin --sbindir=/sbin
    make -j4
    make install DESTDIR=$SYSTEM

### GNU less

You'll have to grab [GNU less](https://www.gnu.org/software/less/) as the BusyBox version isn't functionable. Extract the archive.

    tar xvf less-*.tar.*
    cd less-*

Build and install.

    ./configure --prefix=/usr --bindir=/bin --sbindir=/sbin
    make -j4
    make install DESTDIR=$SYSTEM

### GNU Grep

Grab GNU Grep at [https://www.gnu.org/software/grep/](https://www.gnu.org/software/grep/). Extract the archive.

    tar xvf grep-*.tar.*
    cd grep-*
    
Build and install.

    ./configure --prefix=/usr --bindir=/bin --sbindir=/sbin
    make -j4
    make install DESTDIR=$SYSTEM

### GNU patch

You'll have to grab [GNU patch](https://savannah.gnu.org/projects/patch) as the BusyBox version isn't functionable. Extract the archive.

    tar xvf patch-*.tar.*
    cd patch-*

Build and install.

    ./configure --prefix=/usr --bindir=/bin --sbindir=/sbin
    make -j4
    make install DESTDIR=$SYSTEM
    
#### libattr is required for it to run

You need to get libattr too. Here it is: [https://savannah.nongnu.org/projects/attr](https://savannah.nongnu.org/projects/attr). Extract the archive.

    tar xvf attr-*.tar.*
    cd attr-*
    ./configure --prefix=/usr
    make -j4
    make install DESTDIR=$SYSTEM

## Building man and man-pages

I assume that an explanation of man is redundant. You must have used man at least once in your Linux journey!

Let's grab the dependencies.

### groff

Grab [groff](http://www.gnu.org/software/groff/), a dependency of man. Extract it.

    tar xvf groff-*.tar.*
    cd groff-*

Build and install.

    ./configure --prefix=/usr --bindir=/bin --sbindir=/sbin
    make -j4
    make install DESTDIR=$SYSTEM

### Building man

Grab [man](http://primates.ximian.com/~flucifredi/man/) and extract it.

    tar xvf man-*.tar.*
    cd man-*

Configure man.

    ./configure -ask

At:

   Do you have the nroff source for man pages?  [yes]

Make sure to type yes.

You'll go through a questionaire of whether this is installed etc.. How do you check it? You can chroot into the system and try running those commands. For example, /bin/less -is does not exist for the BusyBox version, as -i is an invalid option. Also, try /bin/commandhere and /usr/bin/commandhere too if the command in the square brackets don't exist. If that works, type the new command, else type "missing".

    Do you want to put the cat pages under /var/cache/man ? [no] 

Type no.

    Do you want to put the cat pages under /var/catman ? [no]

Type no.

    Do you want to install man setuid or setgid to some user
    who owns all the formatted man pages?  [no]

Make sure to type no.

Build and install.

    make -j4
    make install DESTDIR=$SYSTEM

Grab [man-pages](https://www.kernel.org/doc/man-pages/) and extract it.

    tar xvf man-pages-*.tar.*
    cd man-pages-*

And... here's where your life gets easy.

    make install DESTDIR=$SYSTEM
