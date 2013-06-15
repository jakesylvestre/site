---
author: [wei2912]
---
Here's a collection of easy tips for people to apply on their Linux computer. While Linux is pretty fast, who doesn’t want a bit more speed? With this tutorial, you can speed up your OS by pretty much. Note that these tips are generic and may not apply to your computer.

##Kernel

- Load only necessary modules

By default, most modules are loaded when you boot up your Linux system. In fact, most of them are not even required. You can easily change that to load only modules you use by editing /etc/initramfs-tools/initramfs­.conf.

Under the MODULES line, change most to dep.

<!-- more -->

##Packages

- install preload

Preload is an application which optimizes your most often used applications for memory and thus making them faster. Type in the terminal: sudo apt-get install preload

- Install bleachbit

Bleachbit allows you to clean your computer. However, note that performance may not significantly improve. This will only work on Firefox databases or more space for cache. Download the deb file from http://bleachbit.sourceforge.net. Also download the bonus pack for linux to clean more files. Install both deb files.(The following steps will clean your home folder.)

After your installation, run the first launcher - Bleachbit, not Bleachbit (as root). Select > the basic options (skip the very slow options and stuff you may want to keep) and click preview. Check how much memory you can recover from the operation. After that, click clean.

(The following steps will clean the root folder and system files which requires sudo to clean.)

After the cleanup, go to Bleachbit (as root). Select the same options and click preview. Check again, than click clean

- Remove unnecessary programs.

Type this in the terminal:

    sudo apt-get purge brltty brltty-x11 foo2zjs gwibber gwibber-service hplip hplip-cups hplip-data hpijs min12xxw pxljr splix ttf-indic-fonts-core ttf-kacst-one ttf-khmeros-core ttf-lao ttf-punjabi-fonts ttf-unfonts-core

##Login settings

- Disable all unneeded services and applications from starting up (Login)

For services impossible to disable in Startup Applications, install bootup manager (sudo apt-get install bum) and open it. Disable items which are not needed by unchecking them.

##RAM/Swap settings

- Reduce swappiness

Most laptops have enough RAM installed that the swap space on the hard disk shouldn never be used. However, the default setting for swappiness in most Linux systems is 60. By lowering it to 10 we can reduce the number of read/writes on the hard disk. This is especially handy for netbooks with solid state drives in them. Add the following line to /etc/sysctl.conf:

    vm.swappiness=10
    
A value of 10 means that swap will be used when RAM usage goes above 90%.

After a reboot, your system should not use as much swap space as last time.
