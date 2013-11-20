---
layout: post

title: Useful Tiny Commands
category: commands
author: 
  - wei2912
  - manu

summary: Learn how to list hidden files, look at a calender and many more with those pesky tiny commands!
---

Here's a couple of useful commands that we feel are helpful to sysadmins specializing in Linux/Unix/BSD.

## Terminal screens...

### Cleaning up your screens

{% highlight bash %}
$ tput clear
{% endhighlight %}

or simply:

{% highlight bash %}
$ clear
{% endhighlight %}

This clears off everything on your terminal screen. However, if you scroll back, notice the large amount of empty space. In truth, all the clear command does is print out empty lines.

### Reset your screen

{% highlight bash %}
$ reset
{% endhighlight %}

This resets everything on your terminal screen. Unlike *clear* it actually *clears off everything* from your terminal screen.

## Time and Date

### Calender

The format of the command is as such:

{% highlight bash %}
$ cal 12 2024
{% endhighlight %}

where *12* is the month and *2024* is the year.

Here's some example output:

{% highlight bash %}
$ cal 12 2024
   December 2024  
Su Mo Tu We Th Fr Sa  
 1  2  3  4  5  6  7  
 8  9 10 11 12 13 14  
15 16 17 18 19 20 21  
22 23 24 25 26 27 28  
29 30 31  
{% endhighlight %}  

### Displaying both Date and Time

{% highlight bash %}
$ date
{% endhighlight %}

Self explanatory - shows the date.

<!--more-->

## Users

### Who's logged in?

{% highlight bash %}
$ who
{% endhighlight %}

spurts out something like this:

{% highlight bash %}
bar  tty2 2013-03-19 21:46
foo  tty8 2013-03-19 20:38 (:0)
foo  pts/22013-03-19 21:20 (:0.0)
{% endhighlight %}

It displays the currently logged in users and their terminals.

If you want to remove the unneccessary info and display only the users of the system

{% highlight bash %}
$ who | cut -d " " -f1
{% endhighlight %}

Which results in:

{% highlight bash %}
bar
foo
foo
{% endhighlight %}

To remove the duplicates, you need to pipe the info to uniq.

{% highlight bash %}
$ who | cut -d " " -f1 | uniq
{% endhighlight %}

Which results in this:

{% highlight bash %}
bar
foo
{% endhighlight %}

### And another command:

{% highlight bash %}
$ users
{% endhighlight %}

This'll give a list of users showing who is currently online. Instead of a vertical list, it outputs:

{% highlight bash %}
$ users
bar foo foo
{% endhighlight %}

## Processes

{% highlight bash %}
$ ps
{% endhighlight %}

This displays the current running processes in your bash session.

For example, before i ran *jekyll*, I had two processes:

{% highlight bash %}
  PID TTY          TIME CMD
 9683 pts/2    00:00:00 bash
10545 pts/2    00:00:00 ps
{% endhighlight %}

After I ran *jekyll* in background, the content changed:

{% highlight bash %}
  PID TTY          TIME CMD
 9683 pts/2    00:00:00 bash
10545 pts/2    00:00:00 ps
 4898 pts/100  00:00:00 jekyll
{% endhighlight %}

### What about *all* processes?

{% highlight bash %}
$ ps aux
{% endhighlight %}

I won't show the whole thing here, of course...

To find a process, let's say, *java*...

{% highlight bash %}
$ ps aux | grep "java"
{% endhighlight %}

<!--more-->

## Locating files

### Locating commands

{% highlight bash %}
$ type <command>
{% endhighlight %} 
   
Example:

{% highlight bash %}
$ type man
{% endhighlight %} 

You'll obtain something similar to this:

{% highlight bash %}
$ man is /usr/bin/man
{% endhighlight %}

### Finding other files

{% highlight bash %}
$ find /starting/path -name "namehere"
{% endhighlight %} 

For example, to try finding foo:

{% highlight bash %}
$ find / -name "foo"
{% endhighlight %} 

If you know that "foo" is in the directory "bar", you can try this:

{% highlight bash %}
$ find / -name "bar/foo"
{% endhighlight %}

## Variables

### the PATH variable.

The PATH variable is what allows you to easily execute commands without typing unnecessary characters.

It shortens stuff like:

{% highlight bash %}
/usr/bin/man
{% endhighlight %}

to just

{% highlight bash %}
man
{% endhighlight %}

In this situation, the PATH variable must have the path:

{% highlight bash %}
/usr/bin
{% endhighlight %}

Each path is seperated by a colon (:).

To find out what's the contents of your PATH variable:

{% highlight bash %}
$ echo $PATH
{% endhighlight %}

Here's a long one:

{% highlight bash %}
/opt/qt5/bin:/usr/lib/x86_64-linux-gnu/razor-xdg-tools:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/scripts:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platforms:/opt/android-sdk-linux/platform-tools:/home/wei2912/Documents/Programming/Go/bin
{% endhighlight %}

### The PWD variable

PWD stands for "print working directory". It prints out your current location:

{% highlight bash %}
$ pwd
/home/foobar
$ cd ..
$ pwd
/home
{% endhighlight %}

### Which shell am I using right now?

{% highlight bash %}
$ echo $SHELL
{% endhighlight %}

Most of us will be using bash:

{% highlight bash %}
$ echo $SHELL
/bin/bash
{% endhighlight %}

## Listing files

A command you all should know:

{% highlight bash %}
$ ls
{% endhighlight %}

An alternative to "ls" would be "dir".

{% highlight bash %}
$ dir
{% endhighlight %}

But there is a difference between ls and dir. Suppose your working directory has a file called "Sample File". Notice that ls command doesn't show the shell equivalent filename ("Sample\ File") of this file, but it's actual filename ("Sample File") ; whereas, dir command shows it.

To list all files in the working directory including hidden files, you can use:

{% highlight bash %}
$ ls -a
{% endhighlight %}

And to list all the information:

{% highlight bash %}
$ ls -l
{% endhighlight %}

If you want some colors (usually enabled by default but sometimes not):

{% highlight bash %}
$ ls --color=always
{% endhighlight %}

It's good to spice up your terminal!

And if you want to know everything in the directory:

{% highlight bash %}
$ ls -r
{% endhighlight %}

This enables recursive mode and shows all files & directories.

Example:

{% highlight bash %}
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
{% endhighlight %}

## Basic file manipulation

### Touch

Here's a great command that you'll probably need in your Linux journey:

{% highlight bash %}
$ touch filename.txt
{% endhighlight %}

This allows you to create a file if it doesn't already exist.

This command was originally intended to update timestamps, but many users have made use of its file creation ability. As *touch --help* says...

> Update the access and modification times of each FILE to the current time.
> A FILE argument that does not exist is created empty, unless -c or -h is supplied.

### Removing

To remove a file, it's simple:

{% highlight bash %}
$ rm ./file
{% endhighlight %}

To remove a directory, use:

{% highlight bash %}
$ rm -r ./files
{% endhighlight %}

Sometimes, many prompts might appear, like in this case:

{% highlight bash %}
$ rm -r ./files
rm: remove write-protected regular empty file `./files/test'?
{% endhighlight %}

In such cases, you can easily remove all files without confirmation of special cases.

{% highlight bash %}
$ rm -rf ./files
$
{% endhighlight %}

If you want confirmation of everything you're going through:

{% highlight bash %}
$ rm -ri ./files
rm: descend into directory `./files'? y
rm: remove write-protected regular empty file `./files/test'? y
rm: remove directory `./files'? y
{% endhighlight %}

And, if you want to know what you're removing:

{% highlight bash %}
$ rm -rfv ./files
removed `./files/test'
removed directory: `./files'
{% endhighlight %}

The basic procedure of rm is to enter into a directory, look for any files/directories inside, remove files and enter directories till it reaches a dead end, then go out of the directory and remove that directory. Here's a basic example:

{% highlight bash %}
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

{% endhighlight %}

Here, you can see the complex hierachy. Now, let's see how rm goes through these files:

{% highlight bash %}
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
{% endhighlight %}

### Copying

Coming soon!
