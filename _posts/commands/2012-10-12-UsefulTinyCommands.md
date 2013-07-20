---
layout: post
status: draft

title: Useful Tiny Commands
category: commands
tags: 
  - bash
  - commands
author: 
  - wei2912
  - manu-27993

summary: Learn how to list hidden files, look at a calender and many more with those pesky tiny commands!

location: _posts/commands/UsefulTinyCommands.md
---

Here's a couple of useful commands that we feel are helpful to sysadmins specializing in Linux/Unix/BSD :)

## Terminal screens...

### Cleaning up your screens

	tput clear

or simply:

	clear

This clears off everything on your terminal screen. However, if you scroll back, notice the large amount of empty space. In truth, all the clear command does is print out empty lines.

### Reset your screen

    reset
    
This resets everything on your terminal screen. Unlike *clear* it actually *clears off everything* from your terminal screen.

## Time and Date

### Calender

	cal <month> <year>

Example:
	
    cal 12 2024

Here's some example output:

	wei2912@wei2912-desktop[~]$ cal 12 2024
	   December 2024      
	Su Mo Tu We Th Fr Sa  
	 1  2  3  4  5  6  7  
	 8  9 10 11 12 13 14  
	15 16 17 18 19 20 21  
	22 23 24 25 26 27 28  
	29 30 31    

### Displaying both Date and Time

	date

Self explanatory - shows the date.

<!--more-->

## Users

### Who's logged in?

	who
	
spurts out something like this:

	bar  tty2         2013-03-19 21:46
	foo  tty8         2013-03-19 20:38 (:0)
	foo  pts/2        2013-03-19 21:20 (:0.0)

It displays the currently logged in users and their terminals.

If you want to remove the unneccessary info and display only the users of the system

	who | cut -d " " -f1
	
Which results in:

    bar
    foo
    foo
    
To remove the duplicates, you need to pipe the info to uniq.

    who | cut -d " " -f1 | uniq

Which results in this:

    bar
    foo

### And another command:

    users
    
This'll give a list of users showing who is currently online. Instead of a vertical list, it outputs:

    $ users
    bar foo foo
    
## Processes

	ps
	
This displays the current running processes in your bash session.

For example, before i ran *binpress*, I had two processes:

	  PID TTY          TIME CMD
	 4132 pts/3    00:00:00 bash
	 4877 pts/3    00:00:00 ps

After I ran *binpress* in background, the content changed:

	  PID TTY          TIME CMD
	 4095 pts/1    00:00:00 bash
	 4898 pts/1    00:00:00 binpress
	 4901 pts/1    00:00:00 ps

### What about *all* processes?

    ps aux
    
I won't show the whole thing here, of course...

To find a process, let's say, *java*...

    ps aux | grep "java"

<!--more-->

## Locating files

### Locating commands

	type <command>
    
Example:

	type man
	
You'll obtain something similar to this:

    man is /usr/bin/man

### Finding other files

    find /starting/path -name "namehere"
    
For example, to try finding foo:

    find / -name "foo"
    
If you know that "foo" is in the directory "bar", you can try this:

    find / -name "bar/foo"

## Variables

### the PATH variable.

The PATH variable is what allows you to easily execute commands without typing unnecessary characters.

It shortens stuff like:

    /usr/bin/man
    
to just

    man
    
In this situation, the PATH variable must have the path:

    /usr/bin

Each path is seperated by a colon (:).

To find out what's the contents of your PATH variable:

	echo $PATH
	
Here's a long one:

    /opt/qt5/bin:/usr/lib/x86_64-linux-gnu/razor-xdg-tools:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/scripts:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platforms:/opt/android-sdk-linux/platform-tools:/home/wei2912/Documents/Programming/Go/bin

### The PWD variable

PWD stands for "print working directory". It prints out your current location:

    $ pwd
    /home/foobar
    $ cd ..
    $ pwd
    /home

### Which shell am I using right now?

	echo $SHELL

As expected we're using our loved BASH:

    wei2912@wei2912-desktop[~/.dropbox-files/Dropbox/Documents/GitHub/linuxtuts.github.com]$ echo $SHELL
    /bin/bash

## Listing files

A command you all should know:

    ls

An alternative to "ls" would be "dir".

    dir

But there is a difference between ls and dir. Suppose your working directory has a file called "Sample File". Notice that ls command doesn't show the shell equivalent filename ("Sample\ File") of this file, but it's actual filename ("Sample File") ; whereas, dir command shows it.

To list all files in the working directory including hidden files, you can use:

    ls -a

And to list all the information:

    ls -l

If you want some colors (usually enabled by default but sometimes not):

    ls --color=always

It's good to spice up your terminal!

And if you want to know everything in the directory:

    ls -r
    
This enables recursive mode and shows all files & directories.
    
Example:

	wei2912@wei2912-desktop[~/Temporary]$ ls -R files
	files:
	test1  test2  test3  test4  test5  test6  test7  test8  test9
	
	files/test1:
	test11  test12  test13  test14  test15  test1_file1
	
	files/test1/test11:
	test111  test112  test11_file1
	
	files/test1/test11/test111:
	
	files/test1/test11/test112:
	
	files/test1/test12:
	
	files/test1/test13:
	
	files/test1/test14:
	
	files/test1/test15:
	
	files/test2:
	
	files/test3:
	
	files/test4:
	
	files/test5:
	
	files/test6:
	
	files/test7:
	
	files/test8:
	
	files/test9:


## Basic file manipulation

### Touch

Here's a great command that you'll probably need in your Linux journey:

    touch filename.txt
    
This allows you to create a file if it doesn't already exist.

This command was originally intended to update timestamps, but many users have made use of its file creation ability. As *touch --help* says...

    Update the access and modification times of each FILE to the current time.

    A FILE argument that does not exist is created empty, unless -c or -h
    is supplied.

### Removing



To remove a file, it's simple:

    rm ./file

To remove a directory, use:

    rm -r ./files

Sometimes, many prompts might appear, like in this case:

	wei2912@wei2912-desktop[~/Temporary]$ rm -r ./files
	rm: remove write-protected regular empty file `./files/test'?

In such cases, you can easily remove all files without confirmation of special cases.

	wei2912@wei2912-desktop[~/Temporary]$ rm -rf ./files
    wei2912@wei2912-desktop[~/Temporary]$
    
If you want confirmation of everything you're going through:

	wei2912@wei2912-desktop[~/Temporary]$ rm -ri ./files
    rm: descend into directory `./files'? y
    rm: remove write-protected regular empty file `./files/test'? y
    rm: remove directory `./files'? y
    
And, if you want to know what you're removing:

	wei2912@wei2912-desktop[~/Temporary]$ rm -rfv ./files
	removed `./files/test'
	removed directory: `./files'
	
The basic procedure of rm is to enter into a directory, look for any files/directories inside, remove files and enter directories till it reaches a dead end, then go out of the directory and remove that directory. Here's a basic example:

	wei2912@wei2912-desktop[~/Temporary]$ ls -R files
	files:
	test1  test2  test3  test4  test5  test6  test7  test8  test9
	
	files/test1:
	test11  test12  test13  test14  test15  test1_file1
	
	files/test1/test11:
	test111  test112  test11_file1
	
	files/test1/test11/test111:
	
	files/test1/test11/test112:
	
	files/test1/test12:
	
	files/test1/test13:
	
	files/test1/test14:
	
	files/test1/test15:
	
	files/test2:
	
	files/test3:
	
	files/test4:
	
	files/test5:
	
	files/test6:
	
	files/test7:
	
	files/test8:
	
	files/test9:

Here, you can see the complex hierachy. Now, let's see how rm goes through these files:

	wei2912@wei2912-desktop[~/Temporary]$ rm -ri ./files
	rm: descend into directory `./files'? y
	rm: remove directory `./files/test6'? y
	rm: remove directory `./files/test9'? y
	rm: descend into directory `./files/test1'? y
	rm: remove directory `./files/test1/test14'? y
	rm: remove directory `./files/test1/test12'? y
	rm: descend into directory `./files/test1/test11'? y
	rm: remove directory `./files/test1/test11/test112'? y
	rm: remove directory `./files/test1/test11/test111'? y
	rm: remove regular empty file `./files/test1/test11/test11_file1'? y
	rm: remove directory `./files/test1/test11'? y
	rm: remove directory `./files/test1/test15'? y
	rm: remove regular empty file `./files/test1/test1_file1'? y
	rm: remove directory `./files/test1/test13'? y
	rm: remove directory `./files/test1'? y
	rm: remove directory `./files/test8'? y
	rm: remove directory `./files/test4'? y
	rm: remove directory `./files/test5'? y
	rm: remove directory `./files/test7'? y
	rm: remove directory `./files/test2'? y
	rm: remove directory `./files/test3'? y
	rm: remove directory `./files'? y
    
### Copying

Coming soon!
