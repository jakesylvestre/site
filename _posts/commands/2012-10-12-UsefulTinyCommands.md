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

location: _posts/commands/2012-10-12-UsefulTinyCommands.md
---

Here's a couple of useful commands that we feel are helpful to sysadmins specializing in Linux/Unix/BSD.

## Terminal screens...

### Cleaning up your screens

{% prism bash %}
tput clear
{% endprism %}

or simply:

{% prism bash %}
clear
{% endprism %}

This clears off everything on your terminal screen. However, if you scroll back, notice the large amount of empty space. In truth, all the clear command does is print out empty lines.

### Reset your screen

{% prism bash %}
reset
{% endprism %}

This resets everything on your terminal screen. Unlike *clear* it actually *clears off everything* from your terminal screen.

## Time and Date

### Calender

The format of the command is as such:

{% prism bash %}
cal 12 2024
{% endprism %}

where *12* is the month and *2024* is the year.

Here's some example output:

{% prism bash %}
$ cal 12 2024
   December 2024  
Su Mo Tu We Th Fr Sa  
 1  2  3  4  5  6  7  
 8  9 10 11 12 13 14  
15 16 17 18 19 20 21  
22 23 24 25 26 27 28  
29 30 31  
{% endprism %}  

### Displaying both Date and Time

{% prism bash %}
date
{% endprism %}

Self explanatory - shows the date.

<!--more-->

## Users

### Who's logged in?

{% prism bash %}
who
{% endprism %}

spurts out something like this:

{% prism bash %}
bar  tty2 2013-03-19 21:46
foo  tty8 2013-03-19 20:38 (:0)
foo  pts/22013-03-19 21:20 (:0.0)
{% endprism %}

It displays the currently logged in users and their terminals.

If you want to remove the unneccessary info and display only the users of the system

{% prism bash %}
who | cut -d " " -f1
{% endprism %}

Which results in:

{% prism bash %}
bar
foo
foo
{% endprism %}

To remove the duplicates, you need to pipe the info to uniq.

{% prism bash %}
who | cut -d " " -f1 | uniq
{% endprism %}

Which results in this:

{% prism bash %}
bar
foo
{% endprism %}

### And another command:

{% prism bash %}
users
{% endprism %}

This'll give a list of users showing who is currently online. Instead of a vertical list, it outputs:

{% prism bash %}
$ users
bar foo foo
{% endprism %}

## Processes

{% prism bash %}
ps
{% endprism %}

This displays the current running processes in your bash session.

For example, before i ran *jekyll*, I had two processes:

{% prism bash %}
  PID TTY          TIME CMD
 9683 pts/2    00:00:00 bash
10545 pts/2    00:00:00 ps
{% endprism %}

After I ran *jekyll* in background, the content changed:

{% prism bash %}
  PID TTY          TIME CMD
 9683 pts/2    00:00:00 bash
10545 pts/2    00:00:00 ps
 4898 pts/100  00:00:00 jekyll
{% endprism %}

### What about *all* processes?

{% prism bash %}
ps aux
{% endprism %}

I won't show the whole thing here, of course...

To find a process, let's say, *java*...

{% prism bash %}
ps aux | grep "java"
{% endprism %}

<!--more-->

## Locating files

### Locating commands

{% prism bash %}
type <command>
{% endprism %} 
   
Example:

{% prism bash %}
type man
{% endprism %} 

You'll obtain something similar to this:

{% prism bash %}
man is /usr/bin/man
{% endprism %}

### Finding other files

{% prism bash %}
find /starting/path -name "namehere"
{% endprism %} 

For example, to try finding foo:

{% prism bash %}
find / -name "foo"
{% endprism %} 

If you know that "foo" is in the directory "bar", you can try this:

{% prism bash %}
find / -name "bar/foo"
{% endprism %}

## Variables

### the PATH variable.

The PATH variable is what allows you to easily execute commands without typing unnecessary characters.

It shortens stuff like:

{% prism bash %}
/usr/bin/man
{% endprism %}

to just

{% prism bash %}
man
{% endprism %}

In this situation, the PATH variable must have the path:

{% prism bash %}
/usr/bin
{% endprism %}

Each path is seperated by a colon (:).

To find out what's the contents of your PATH variable:

{% prism bash %}
echo $PATH
{% endprism %}

Here's a long one:

{% prism bash %}
/opt/qt5/bin:/usr/lib/x86_64-linux-gnu/razor-xdg-tools:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/scripts:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platforms:/opt/android-sdk-linux/platform-tools:/home/wei2912/Documents/Programming/Go/bin
{% endprism %}

### The PWD variable

PWD stands for "print working directory". It prints out your current location:

{% prism bash %}
$ pwd
/home/foobar
$ cd ..
$ pwd
/home
{% endprism %}

### Which shell am I using right now?

{% prism bash %}
echo $SHELL
{% endprism %}

As expected we're using Bash:

{% prism bash %}
$ echo $SHELL
/bin/bash
{% endprism %}

## Listing files

A command you all should know:

{% prism bash %}
ls
{% endprism %}

An alternative to "ls" would be "dir".

{% prism bash %}
dir
{% endprism %}

But there is a difference between ls and dir. Suppose your working directory has a file called "Sample File". Notice that ls command doesn't show the shell equivalent filename ("Sample\ File") of this file, but it's actual filename ("Sample File") ; whereas, dir command shows it.

To list all files in the working directory including hidden files, you can use:

{% prism bash %}
ls -a
{% endprism %}

And to list all the information:

{% prism bash %}
ls -l
{% endprism %}

If you want some colors (usually enabled by default but sometimes not):

{% prism bash %}
ls --color=always
{% endprism %}

It's good to spice up your terminal!

And if you want to know everything in the directory:

{% prism bash %}
ls -r
{% endprism %}

This enables recursive mode and shows all files & directories.

{% prism bash %}
Example:

$ ls -R files
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
{% endprism %}

## Basic file manipulation

### Touch

Here's a great command that you'll probably need in your Linux journey:

{% prism bash %}
touch filename.txt
{% endprism %}

This allows you to create a file if it doesn't already exist.

This command was originally intended to update timestamps, but many users have made use of its file creation ability. As *touch --help* says...

Update the access and modification times of each FILE to the current time.

A FILE argument that does not exist is created empty, unless -c or -h
is supplied.

### Removing

To remove a file, it's simple:

{% prism bash %}
rm ./file
{% endprism %}

To remove a directory, use:

{% prism bash %}
rm -r ./files
{% endprism %}

Sometimes, many prompts might appear, like in this case:

{% prism bash %}
$ rm -r ./files
rm: remove write-protected regular empty file `./files/test'?
{% endprism %}

In such cases, you can easily remove all files without confirmation of special cases.

{% prism bash %}
$ rm -rf ./files
$
{% endprism %}

If you want confirmation of everything you're going through:

{% prism bash %}
$ rm -ri ./files
rm: descend into directory `./files'? y
rm: remove write-protected regular empty file `./files/test'? y
rm: remove directory `./files'? y
{% endprism %}

And, if you want to know what you're removing:

{% prism bash %}
$ rm -rfv ./files
removed `./files/test'
removed directory: `./files'
{% endprism %}

The basic procedure of rm is to enter into a directory, look for any files/directories inside, remove files and enter directories till it reaches a dead end, then go out of the directory and remove that directory. Here's a basic example:

{% prism bash %}
$ ls -R files
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

{% endprism %}

Here, you can see the complex hierachy. Now, let's see how rm goes through these files:

{% prism bash %}
$ rm -ri ./files
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
{% endprism %}

### Copying

Coming soon!
