---
layout: post
title: Shell Shortcuts
category: shells
tags: [bash, shortcuts, shells]
author: [wei2912]
summary: Shells have many useful features and shortcuts. Learn some of them in this tutorial!
status: draft

location: _posts/programming/2012-12-29-ShellShortcuts.md
---

Let's take a look at a couple of case scenarios.

## 1st case scenario: Creating 9 directories, with disk1 till disk9

You have a /mnt directory and for convienence, you want to create a couple of easily accessible mount points, labelled disk1 to disk9. Instead of creating each directory seperately, here's what you could do:

    cd /mnt
    mkdir disk{1..9}
    
Using {1..9} creates an array of 1 to 9. Since there are 9 possible values in that array, there are 9 commands:

    mkdir disk1
    mkdir disk2
    mkdir disk3
    mkdir disk4
    mkdir disk5
    mkdir disk6
    mkdir disk7
    mkdir disk8
    mkdir disk9
    
All these commands are executed, creating 9 directories in a flash.

__Take a look at [http://playterm.org/r/bash-arrays-1357464164](http://playterm.org/r/bash-arrays-1357464164).__

<!--more-->

## 2nd case scenario: Copying everything in a directory without copying the directory itself.

You have two duplicate folders, both named foo. The first one is at ~/foo, the second one is at /root/foo. You want to merge them together and then replace them with a symbolic link. How'd you do this?

    mv ~/foo/* /root/foo
    
This moves everything in the first folder to the other folder.
    
Let's delve into this.

Assuming that ~/foo has:

    wei2912@wei2912-server[~/foo]$ ls
    test2  test3  test4  test5

And /root/foo has:

    root@wei2912-server:~/foo# ls
    test1  test6  test7  test8  test9

(notice that I am in the root account)

You can see that ~/foo has test2 to test5 while /root/foo has test1 and test6 to test9. Once we merge them we'll have test1 to test9 in /root/foo.

After we execute the command:

    root@wei2912-server:~/foo# mv /home/wei2912/foo/* /root/foo
    root@wei2912-server:~/foo# ls
    test1  test2  test3  test4  test5  test6  test7  test8  test9

We've successfully merged the directories using a wildcard. What the wildcard does is put everything in the path into an array. These commands are executed:

    mv /home/wei2912/foo/test2 /root/foo
    mv /home/wei2912/foo/test3 /root/foo
    mv /home/wei2912/foo/test4 /root/foo
    mv /home/wei2912/foo/test5 /root/foo

Try this:

    echo /root/foo/*
    
This will print everything in that directory to the console.

__Take a look at [http://playterm.org/r/bash-merge-directory-1357470213](http://playterm.org/r/bash-merge-directory-1357470213).__

## 3rd case scenario: forgetting to add sudo infront of a command (specific to Bash)

This is really common. Let's say you need to do a package installation on a Debian system.

    wei2912@wei2912-server[~]$ apt-get install wine1.5
    E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)
    E: Unable to lock the administration directory (/var/lib/dpkg/), are you root?

Don't bother pressing the up button and scrolling the cursor to the front, then adding 'sudo'. There's no need.

	wei2912@wei2912-server[~]$ sudo !!
	sudo apt-get install wine1.5
	Reading package lists... Done
	Building dependency tree       
	Reading state information... Done
	The following extra packages will be installed:
	  wine1.5-amd64 wine1.5-i386:i386
	Suggested packages:
	  dosbox:any
	Recommended packages:
	  ttf-droid ttf-mscorefonts-installer ttf-umefont ttf-unfonts-core ttf-wqy-microhei winbind libcapi20-3 libosmesa6 libsane libtiff4 unixodbc libgif4:i386
	  libosmesa6:i386 libtiff4:i386 unixodbc:i386
	The following NEW packages will be installed:
	  wine1.5 wine1.5-amd64 wine1.5-i386:i386
	0 upgraded, 3 newly installed, 0 to remove and 8 not upgraded.
	Need to get 47.2 MB of archives.
	After this operation, 235 MB of additional disk space will be used.
	Do you want to continue [Y/n]? 
	
As you can see above, 'sudo !!' is interperated as 'sudo apt-get install wine1.5' as the previous command is 'apt-get install wine1.5'. '!!' is the previous command.

Let's try this:

	wei2912@wei2912-server[~]$ echo !!
	echo apt-get install wine1.5
	apt-get install wine1.5
    
(note: the previous command would be different after you execute the second command, so execute the first one again)

Notice that there appears to be two previous commands. Actually, there aren't. The first line is what the Bash shell outputs as the command going to be executed. The second line is the actual output.
