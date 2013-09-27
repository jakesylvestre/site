---
layout: post
status: post

title: Using chmod and chown
category: commands
tags: 
  - bash
  - commands
  - chmod
  - chown
author: 
  - wei2912
  - jaffer1979
  - manu-27993

summary: Learn how to master the two commands that are often associated with file permissions manipulation - chmod and chown.

location: _posts/commands/2013-06-24-Chmod&Chown.md
---

This was originally a class at [http://piratepad.net/NixTuts-LinuxCmdLine-9psZK](http://piratepad.net/NixTuts-LinuxCmdLine-9psZK), so feel free to visit it if you want to experience something more interactive.

## Chmod

So, what's chmod?

Looking at the manpage of chmod, as quoted:

> chmod - change file mode bits

These "file modes" will be covered later. In short, it lets you change the file permissions. You can change a file permission only if you match any of these criteria:

1. You are the owner of the file.

2. You are the root user.

3. You are already given permission to modify file permissions by the owner or a root user.

<!--more-->

## Methods of using chmod

There are two ways of changing the File Permissions:

1. Symbolic notation

2. Numeric notation

The difference lies only in the "option" part of the command.  

## Getting Started

First, let's create a file in your home directory.

{% highlight bash %}
$ touch file
$ ls -l file
-rw-r--r-- 1 wei2912 weigrp 0 Jun 24 15:26 file
{% endhighlight %}

This file was created with the command [touch](/commands/UsefulTinyCommands.html#touch). Following the touch command is the [ls -l](/commands/UsefulTinyCommands.html#listing_files) command which lists out the file attributes.

The File attributes, as shown by ls -l command, gives you these information:

1. File type and Permissions

2. Links (total no. of links created to this file)

3. File Owner (who created the file? / who owns it now?)

4. Group Ownership (what group the Owner belongs to?)

5. Size in bytes (no. of characters in its source)

6. Last Modification Date and Time (if the file was modified more than a year ago, the year is shown instead of the time)

7. Filename

## Changing the File Permission using symbolic notation

The "option" part in this method can be divided into three parts:

{% highlight bash %}
user/group/others action modes
{% endhighlight %}

so that we can write the syntax for this method as:

{% highlight bash %}
chmod user/group/others action modes
{% endhighlight %}

### user/group/others

It means what users are affected by the change in permission.

    u --> affects the current user  
    g --> affects the group of current user     
    o --> affects all other users
    a --> affects all users (equivalent of ugo)

These modes can be combined together. For example, ug affects the current user and the group but not others.

### action

It means what action to be taken:

    = --> assign permission
    + --> grant permission
    - --> withdraw permission

Assigning permissions is absolute (if your file has rwx at the start and you assign r to it, it'll have r-- permissions). Granting and withdrawing permissions is relative (if your file has rwx at the start and you withdraw r from it, it'll have -wx permissions).

### modes

First, let's zoom into this:

    -rw-r--r--

Breaking it into parts:

    - rw- r-- r-- 

The first character tells a user which type of file this is. (d means a directory file, - means a normal file). In Linux, there are three types of modes that apply to permissions manipulation: Read, Write and eXecute. A full permissions would look like this:
 
    rwx

However, if for example, a user, group or others has only read and write, the x section would be replaced with -, resulting in this:

    rw-

In this case, the first section, rw-, refers to the user being able to read and write. The second section, r--, refers to the user's group being able to read only. The third section, r-- as well, applies to others. It means that for others, the file is read only. 

Here's a view of what it looks like:

    - rw-     r--     r--
       |       |       |
      user    group   others
       |       |       |
      read    read    read
      write

### Examples

{% highlight bash %}
chmod u+x file  # grants the current user execute permission for the file
chmod go-wx file # withdraws write and execute permissions from the group and others
chmod a=rw file  # assigns read and write permissions for all users
{% endhighlight %}

Remember the output we showed previously using "ls -l"? The 3rd and 4th columns are shown below:

{% highlight bash %}
wei2912 weigrp
{% endhighlight %}

This section means this belongs to user **wei2912** of group **weigrp**. To change this, [chown](/commands/Chmod&Chown.html#chown) is used. This will be covered later.

### Exercises

A directory's "ls -l" shows this output:

{% highlight bash %}
drwx------  2 wei2912 weigrp  4096 Jun 17 18:19 bin
{% endhighlight %}

What are the permissions of this directory and who owns it?

**Answer:**

User **wei2912** from group **weigrp** owns the directory. Only the user can read, write and execute.

## Changing file permissions using numeric notation

Sometimes, you might see someone state that a file has permissions "0777". What exactly does this mean?

Let's break it up into smaller parts again.

    0777 -> 0 7 7 7

That doesn't seem to look like much, but each digit signifies something. Let's ignore the first digit for now. The 2nd digit represents the current user, 3rd the group and 4th other users.  

Looking at the last three digits, what do you think it means? This can be interpreted using the following table:

    Digit | XXX | rwx | What it does?
    0     | 000 | --- | Assigns no permissions
    1     | 001 | --x | Assigns execute permission
    2     | 010 | -w- | Assigns write permission
    3     | 011 | -wx | Assigns write and execute permissions
    4     | 100 | r-- | Assigns read permission
    5     | 101 | r-x | Assigns read and execute permissions
    6     | 110 | rw- | Assigns read and write permissions
    7     | 111 | rwx | Assigns all read, write and execute permissions

The first column indicates what number to use. The second column indicates its binary value of 3 bits, with the bits representing modes r, w and x respectively. The third column tells you what it is in symbolic notation, and the fourth tells you what it does.

This is known as **numeric notation**. In this case, 0777 translates to rwxrwxrwx.

### Examples

{% highlight bash %}
chmod 664 file # rw-rw-r--
chmod 764 file # rwxrw-r--
{% endhighlight %}

### Exercises (again)

Translate these codes into symbolic notation:

1. 777
2. 755

**Answer:**

1. rwx rwx rwx
2. rwx rw- rw-

## Here's another exercise!

A directory, bin/, has permissions 777. You wish to remove write permissions from group and others. How'd you do this?

For this question, you need to supply two ways:

1. Using symbolic notation
2. Using numeric notation

Also, please note that in chmoding a whole directory, you should use the recursive flag.

{% highlight bash %}
chmod -R blah blah blah
{% endhighlight %}

This means that changes apply to all directories and files contained within. To view which files will be changed, you can try "ls -R file/directory".

**Answer:**

1. chmod -R go-w bin/
2. chmod -R 755 bin/

While doing the exercise, did you notice something between numeric and symbolic notation?

Let's try another exercise to find out.

## Again, an exercise!

File qwerty has permissions `rwxrwx---`

What's the final file permissions after doing:

{% highlight bash %}
chmod o+rx qwerty
{% endhighlight %}

**Answer:**

{% highlight bash %}
rwxrwxr-x
{% endhighlight %}

Also, if file qwerty had permissions `---------`, what'd be the final file permissions?

**Answer:**

{% highlight bash %}
------r-x
{% endhighlight %}

**Using symbolic notation is relative to the file's permissions.**

Now, let's try with numeric notation.

{% highlight bash %}
chmod 775 qwerty
{% endhighlight %}

What happens to the file permissions if qwerty had file permissions `rwxrwx---` originally?

**Answer:**

    rwxrwxr-x

Now, what happens if qwerty had file permissions `---------` instead?

**Answer:**

    rwxrwxr-x 

**Using numeric notation is absolute and does not depend on the original file's permissions.**

Thus, by using numeric notation, you could save a lot of typing required for symbolic notation. If you wish to assign absolute permissions using symbolic notation, you can use '=', as mentioned above.

## chown

So, what's chown?

This command is used to change the ownership of a file/directory. As the manpage sums it up:

>  chown - change file owner and group

As you know from above, in Linux, there's a user and a group. chown sets a file to a specific user and group.

Here's the syntax:

{% highlight bash %}
chown user:group file
{% endhighlight %}

Just like chmod, chown has a recursive mode used for directories. This means that changes apply to all directories and files contained within. To view which files will be changed, you can try "ls -R file/directory".

{% highlight bash %}
chown -R user:group directory
{% endhighlight %}

That's about it. Chown is rather easy to use once you've mastered the concepts of users and groups.

### Exercises

Set folder "wireshark" to user wireshark and group wireshark. (PS: There's a Wireshark tutorial available at [Wireshark](/networking/Wireshark.html))

**Answer:**

{% highlight bash %}
chown -R wireshark:wireshark wireshark/
{% endhighlight %}

## Conclusion

chown and chmod are commands that you'll definitely use at least once (and probably hundreds of times) in your Linux life. Master them well and you'll definitely benefit from it.
