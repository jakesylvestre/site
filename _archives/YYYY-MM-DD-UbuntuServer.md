---
layout: post
title: Building up from Ubuntu Minimal
category: ubuntu
tags: [ubuntu, minimal, lightweight, base]
author: [wei2912]

status: draft
---
####################################################

A beginners guide to setting up a Linux server.
by: Cool Fire

####################################################


Preface
1. Selecting a hardware.
2. Selecting a location.
3. Choosing a Linux distribution
4. Deciding on services you'll run
5. Installing Linux
5.1 Partitions
5.2 Base system
5.3 Installing packages
6. Configuration
6.1 Base system
6.1.1 sudo
6.1.2 apt
6.2 OpenSSHd
6.3 Webmin
6.4 Apache2
6.5 ProFTPd
6.6 MySQL
6.7 PHPmyAdmin
6.8 Router config
7. User management
8. Updating
9. Final thoughts


Preface:

This guide is written for people who have very little to no knowledge of Linux and want to get their feet wet in running their own server. This guide was written with the usage of Debian 4.0 in mind, so later versions might have slight modifications.
Also, I have no idea what else goes in a preface. I'll have to look that up sometime...


1. Selecting a hardware.

The first thing to remember is you don't need a lot of fancy hardware to set up a simple server, and if you're planning on setting up a really high-end server and you're reading this. Well, you're probably pretty screwed. All the same, let's dive into it. In this example we'll be setting up a small personal server. For this, some old PC you might have laying around will do just fine. I've used an old Pentium 3 (800 mHz) with 128 Mb of ram for a long time, and that was still pretty big overkill. Keeping power consumption in mind, an old Pentium 2 would be a good choice since they have a really good speed to power consumption ratio. For networking hardware you don't need much either, basically the only thing is that it's better to use a wired then wireless connection, since they're far more reliable. Other then that it doesn't matter much since the limiting factor will be your outside internet connection speed.

Now obviously our server PC is going to be switched on all the time, so unless you have a place to tuck it away where the sound doesn't bother you, you could invest in some quiet fans and coolers to help any noise. Also old hard drives can be loud, and a new one won't set you back a whole lot.
While on the subject of hard drives, it's again not really an issue how fast or new they are, since a simple old IDE drive is still a lot faster then the network, so putting a faster on in there won't be something you notice at all. The main thing for how big it should be depends on what you'll be using it for. If you are planning on storing your movie / music collection on there, you might have to upgrade if you're using an old PC, but that's pretty much up to your own judgment. If you don't plan on putting a lot of big stuff on it, really you don't need more then a 10-20Gb drive. (I've even seen web servers with 800MB drives.)


2. Selecting a location.

Most servers are in a corporate server room or a data center. For our example we'll just stick to our server being at home in a closet or something. Data centers are fine, but they can be pricey, and they don't just allow you to put any computer in there. All you need to look out for when you're picking a spot to put your server-to-be, is that there's room for it to fan out the hot air (so don't back it up to a wall too close.) Other then that just the obvious things like that there's electricity and an internet connection. Note that you really won't need room for stuff like a keyboard, mouse or screen, since you don't uses those on a server after you've done the initial setup.


3. Choosing a Linux distribution

What flavor of Linux you want to put on there is really up to you. For this example we'll be using Debian 4.0 for two main reasons;
1. It's a solid system, tried and true, easy to maintain, light customizable enough for old hardware.
2. It the basis for Ubuntu, which I bet a lot of you will end up using the server distribution of.
Some other ones that deserve a good look would be Fedora, OpenSUSE (not too good for older hardware though) and Slackware (A bit more advanced).
There's tons of other distributions out there, so feel free to poke around and see if there isn't anything you like better, or that suits what you want to do with your server more.


4. Deciding on services you'll run

There's a few things which are pretty essential for your server, the most important would have to be the SSH server (OpenSSHd). This allows you to log into your server over a network so you don't have to physically go over to the machine every time you need to do something. Hence why in general you don't use keyboards/mice/screens on servers. This can be done with a private home server, but gets just a bit tricky when your server is in a data center at the other end of the world. Also a Webmin server is a godsend in many cases, since it offers a web based user interface to pretty much anything you want to do on your server.
Other then that it really depends on what you'll be doing with it. If you want to host your own website, you'll need a web server (Apache being the most common one). Want to have a database included, you need a database server. It's plain logic really.
In this example we'll have the following installed;
- OpenSSHd (Allow remote login to the server.)
- Webmin (Allow a easy user interface for configuration and maintenance.)
- Apache2 (Host web pages.)
- ProFTPd (Host files.)
- MySQL (Database server.)
- PHPmyAdmin (A web interface for the database.)

Other services you could consider are;
- Samba (Create windows-style shared folders)

There is just one more thing to keep in mind when selecting software to install, and that is that usually we don't install graphical user interfaces (Like the X window system) on servers, since they take up a fair amount of space and generally just don't get used at all. There's no real harm in installing them, but when you're working with limited disk space, it's a good space saver.


5. Installing Linux
5.1 Partitions

In the case of a server we don't have to worry about things like dual booting, so partitioning is a lot easier. In most cases you can just let the installer do it's thing, and the default configuration is fine. However, in case it's not, and just to explain it, it should go a little something like this; (assuming we only have one disk, and that this disk is called /dev/hda.)
Partition 1:
name: /dev/hda1
type: ext2/ext3/reiserfs (Depending on your drive)
size: about 200 MB.
mount point: /boot

Partition 2:
name: /dev/hda2
type: swap
size: about twice the size of your RAM.
mount point: none (swap)

partition 3:
name /dev/hda3
type: ext2/ext3/reiserfs (Depending on your drive)
size: rest of your drive space
mount point: /

Two things need to be said here. First, this is not a fixed scheme, and you can do it almost any way you like. A swap drive is very highly recommended, but you can choose not to have one. It can make a lot of sense to make a separate partition for /home and make / a lot smaller (2-3 GB), especially if you're going to let other users on your system too.
You can also just have a root partition (the / one) and a swap, which will work just fine, but for a server it's not a bad idea to separate them from a security standpoint.
Second: I've said "Depending on your drive" twice (3 times now, but who's keeping score), so I'll explain. The ext2 filesystem is the oldest one, but by no means obsolete, in fact it's the best choice for small drives (say, under 10 Gb). After that it's fair game between ext3 and reiserfs (presonally, I prefer reiserfs since it doesn't have to deal with inodes).
There are a lot of other filesystems, but we won't be looking at those for this example.


5.2 Base system

We'll be using a Debian 4.0 Net Install CD for this example.
When you start your install from the cd you'll see a Debian boot screen asking you to press enter. I'd suggest you do just that. :p
After some base loading the installer will start, you'll first be asked for some basic settings like language, location and keyboard layout.
When it finishes loading some additional components it will try to automatically get an IP address via DHCP, if this fails it will ask you to either enter the network information yourself, or let it try DHCP configuration again.
You'll be asked to set a hostname (Your servers name) and a domain name (if you don't have one, just leave the default)

Now it will drop you into the partition manager which will either allow you to use the free space on the disk, use all the space on the disk, or let you define your own partition scheme (which we'll be doing today).
If there are any partitions on the drive you are using, you should delete those first. (Note, any data still on them will be lost!)
We've already decided what partitions to create in the previous chapter, so it's pretty easy now.
Go onto the free space, and hit enter, then create new.
You'll have to decide or you want a primary or logical partition, normally we only use logical partitions when we need more then 4 partitions on a single disk. (Since that's the limit of primary partitions.)
It will ask you for the size, since we'll start with our /boot partition, we'll make it '200 MB' (It understands basic size indications like KB, MB, GB but also relative size indications like 50 %)
You'll now see a configuration for your partition, by default it picks Ext3.
It will also ask you if you want your partition at the beginning or the end of the available free space. Just pick whichever you feel like, it doesn't matter much.
- Set the mount point to /boot
- Set the bootable flag on (If you don't do this, you're system might not start at all!)
- You can, set the mount options to ro (read only). This will prevent accidental deletion of boot files, but you'll have to remember to remount it writable if you are upgrading any boot components.)

Our next partition is swap, so we'll make another new partition, much the same way as the last one.
I'll be making it 1 Gb, as there is 512 Mb of ram in my machine.
Now when we reach our configuration for the partition set the change Etx3 to swap.
Notice swapspace doesn't have as many options as a normal partition. You don't need to change any of the other settings.

Finally, we make one more partition, with all the available free space we have left.
I've made this one ReiserFS, but as we talked about, that choice is up to you.
Make sure it's got / set for it's mount point.
Other then that, the defaults should be fine.
Now we can select "Finish partitioning and write changes to disk." in the partitioner.
It will ask you for one final conformation before writing your new partitions.

The installer will resume and ask you to specify a root password. This is pretty much the most important password on your system in most cases, so make it a good one.
Now you'll have to make a normal user account for yourself (since we don't want to be doing everything as root, typically.)
It will ask for your name, a username (what you type to log in) and a password. (This is your main useraccount, so strong passwords are again a must.)

The installer will now set up the base system.

You now have to configure the package manager. Luckily this is really easy, you just select a server somewhere near you, and if you wish you can set a proxy.
(You'll now be prompted to enter in the package popularity contest, you can, but don't have to. Just see for yourself.)
Next we have to decide which software super packages (packages that contain a lot of other packages) we want installed. We can pick from the following:
[ ] Desktop
[ ] Web server
[ ] Print server
[ ] DNS server
[ ] File server
[ ] Mail server
[ ] SQL server
[ ] Laptop
[*] Standard system

I'll just be installing the standard system so I can show you how to set up certain other thing manually later on. But obviously you can select some stuff you want here.
When you finish your selection, it'll start downloading and installing the selected packages, this can take a while depending on your internet speed and number of packages you selected for install.

Once this finishes, you'll be asked to install the GRUB boot loader, this is what loads the linux system when you power you server on.
In most cases you should install it to the MBR (Master Boot Record).

The installation will now finish. You can remove your install CD and reboot to start your new Linux install!
(Note: The first time you boot may take a little longer then it normally would.)


5.3 Installing packages
Some of these things will be installed during the main setup, but for the sake of our example we'll pretend they didn't. On our Debian system installing software is just a breeze thanks to aptitude.
All we do to install the following packages;
- OpenSSHd
- Apache2
- ProFTPd
- MySQL
- PHPmyAdmin
- PHP
- Perl
- Python
- Ruby
- Sudo

- Webmin

is this: "aptitude install openssh-server apache2 proftpd mysql-common mysql-client-5.0 mysql-server-5.0 php5 phpmyadmin perl python2.5 ruby sudo"
It will ask you to confirm the packages selected for install, hit Y followed by Enter to do so.
You might be asked to re-insert your install CD, just do so for now, we'll fix that in chapter 6.1.2.
You'll be prompted about the ProFTPd install, asking you whether you want an inet or standalone configuration. In most cases standalone is preferred.
And that's it! All the rest of the work is done for us. (Let's give thanks to the Debian developers for this great system, a moment of silence please.)

But wait, what about that super-package "webmin" I keep talking about? Well, at this time it's not in the Debian repository, so we'll have to install it on our own. Luckily that's not as daunting a task as it sounds at all. We can download a Debian package, which is a big help for us (You can also download packages for a lot of other common distributions or build it from sourcecode)
To get the Debian package we do:

Code:
    sudo aptitude install libnet-ssleay-perl openssl libauthen-pam-perl libio-pty-perl libmd5-perl
    wget http://prdownloads.sourceforge.net/webadmin/webmin_1.420_all.deb
    sudo dpkg --install webmin_1.420_all.deb


(Notes: By the time you read this, newer versions might be available, so check http://www.webmin.com)
(Note:The extra packages installed are needed by webmin)

You can now have a look at your webmin interface at https://whatever.the.server.ip:10000.

Ok, now remember that at the time you read this, some of these might have newer versions, so for example, to check for a newer version of php, just type "aptitude search php" and it'll spit out all the php related packages. You'll be able to find a newer version there if there is one.


6. Configuration

6.1 Base system
6.1.1 Sudo
The sudo command is used to allow normal user accounts root access. This is good for us, since this means we can disable remote root login later on without causing problems for ourself.

Code:
    pico /etc/sudoers


Go to the bottom of the file, and add a line much like the one for "root" except with your own username.

Code:
    username ALL=(ALL) ALL



6.1.2 Apt
The apt system is what allows us to install software from the online repositories, but ny default it will ask you for your install CD before going to a online source. Not too good if our server is tucked away somewhere, so we'll stop it doing that.

Code:
    sudo pico /etc/apt/sources.list


This is the file where it keeps track of which repositories to use, so simply remove the line starting with "cdrom:" and save the file. (if you're using nano or pico, hit Ctrl+X, Y, Enter. You should now be back you the command line.)

6.2 OpenSSHd
The only thing you may want to change from the default configuration is disallowing the remote login of 'root' since a lot of automated attacks focus on this account. If you just disallow remote root login altogether, no matter if they guess/steal/torture you out of the password, they still won't be able to log in so it makes sense to do this.
Just open up the following file:
/etc/ssh/sshd_config (Just type "nano /etc/ssh/sshd_config" if you're not sure which editor to use.)
Then find the following line:
"PermitRootLogin yes"
Now just change the 'yes' to 'no' and save the file. (if you're using nano or pico, hit Ctrl+X, Y, Enter. You should now be back you the command line.)
Finally, type '/etc/init.d/ssh restart' to restart the ssh server with the new configuration.

6.2 Webmin
It's probably a good idea to create a webmin user for yourself and disabling the root account, since that will be the obvious choice for any attacker.
To do so, follow these steps:
- Log into webmin using the root account.
- Go to Webmin > Webmin users > Create a new webmin user
- Enter user details
- Hit 'select all'
- Hit 'create' at the bottom of the page.
- Select user "root"
- Set authentification to "No password acccepted"
- Hit 'Save'
(Note: You can user your user account for this you create earlier and set the authentication to 'unix authentication' or create a new user.)

6.3 Apache2
Really there's not much you need to do to the default settings of apache. You can perhaps look around in webmin and see if you come across any interesting settings.
By default the main directory is located at "/var/www/apache2-default". In there it check for index.html to load first. (If you're index page is called index.php, make sure to delete the default index.html)

6.4 ProFTPd
Again there's not too much to change about the default settings, unless you want to enable anonymous user login.
We'll do that for our example.
Kindly enough the proFTPd configuration file comes with an example for anonymous users that's just commented out, so all we need to do to enable it, is remove the comment symbols.
Open up the "/etc/proftpd/proftpd.conf" file. (Again, just do "nano /etc/proftpd/proftpd.conf" if you're not sure.)
Find where it says: "# A basic anonymous configuration, no upload directories."
and remove all the '#'s from the start of the line untill you get to "</Anonymous>". Note that some lines like " # We want clients to be able to login with "anonymous" as well as "ftp". " are meant to be left with a '#' since they are really comments. Remove these and your configuration file will not work!
Now all there's left to do is restart our FTP server so it uses the new configuration, and we do that by typing this:
"/etc/init.d/proftpd stop" to stop it, and "/etc/init.d/proftpd start" to start it again. Pretty straight forward no?

6.5 MySQL
First you should set a root password, since this is not done be default.

Code:
    mysqladmin -u root password NEWPASSWORD



6.6 PHPmyAdmin
This is pretty much set up right by default.
log in at; http://whatever.the.server.ip/phpmyadmin

6.7 Router config
In most cases you'll be using DHCP to provide get an IP address from your router, but make sure that these don't change over time, because you're server won't be accessible from the internet if it does. (Some linksys routers have a tendency to do this.) If indeed it does change, you'll have to set up static IP addresses, or possibly a combination of these. But we won't dive into that since it's a bit far off the topic of this text.
So what you need to know, is what IP address your server has (type "ifconfig" to check, in most cases the used connection is called eth0).
Well, I can't really write this into a guide since it depends greatly on what networking hardware you use. However, your manual or manufacturers website should provide the information you need to set up port forwarding.
The ports you will be using are:
ftp: 21
ssh: 22
http: 80
mysql: 3306
webmin: 10000


7. User management

Adding new users to your system is something you can write a script for, but if your server is anything like mine, it won't have all that many users and it's really not worth the effort.
(Later we'll whip up a little example script all the same though, just for the heck of it.)
By default, all the users will have their own folder on the machine to store all their files and such, this is located at /home/username (hence why having a separate partition for /home could be useful).
Other then that, all you need to do is type "adduser username" and you'll be prompted for some info, about the user, but the only thing you really need to specify is a password.
Remember you'll have to be root (or a sudo user) to execute this command.
Removing users is pretty much the just as easy, just type "userdel -r username". the -r option makes sure all his files and /home directory are removed too.
You can also suspend user account, disable them and all sorts of neat stuff, but the easiest way to do that is trough our webmin interface. ;)
Really you can do anything with webmin, but it's good to know how to do it manually too, since you might one day find yourself managing a server that doesn't have webmin installed or something.
There's a million reasons to be able to do it without, and only one to do it with webmin. It's hellah easy.


8. Updating

In the case of our example we're using a Debian system, which makes updating a breeze. Just log in, and type "aptitude update" to update all the package lists, and "aptitude upgrade" to preform the updates. Obviously we could script these to run daily or so, and make our life easier, but remember to do it manually every now and then because something might come up that your script can't handle and then it won't update anymore.
If you're not using Debian or a Debian-based system, the update procedure will be different, but a lot of distributions come with really good software and update management systems which will allow you to update just as easily.

auto update example:

Code:
    sudo -s
    pico /etc/cron.daily/server_update


Code:
    #!/bin/sh
    echo " ------------------ " >> /home/user/update.log
    echo `date +%Y-%m-%d-%H-%M` >> /home/user/update.log
    echo " ------------------ " >> /home/user/update.log
    apt-get update
    apt-get -y -f upgrade world >> /home/user/update.log
    echo `date +%Y-%m-%d-%H-%M` " Update finished"  >> /var/log/messages


Code:
    chmod +x /etc/cron.daily/server_update


This writes all your update info to a log file, but you can also direct the output to /dev/null if you don't want any logs.


9. Final thoughts

If you've just read this, and thought to yourself "wow, that was a waste of my time." Then why did you bother reading it? Oh well, your loss.
Anyway, all I can say is that I hope people will find this guide helpful, and the best of luck to everyone who's just set up their very own Linux server!
(Fun fact: An install like this will give you a system using less then 750 MB of disk space.)

Regards, Cool Fire
