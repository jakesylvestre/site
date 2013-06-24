---
layout: post
status: post

title: Using chmod and chown
category: commands
tags: [bash, commands, chmod, chown]
author: [wei2912]

status: draft

summary: Learn how to master the two commands that're often associated with file permissions manipulation - chmod and chown.
location: _posts/commands/Chmod&Chown.md
---

This was originally a class at [http://piratepad.net/NixTuts-LinuxCmdLine-9psZK](http://piratepad.net/NixTuts-LinuxCmdLine-9psZK), so feel free to visit it if you want to see something more interactive.

# Chmod

So, what's chmod?

Looking at the manpage of chmod, as quoted:

> chmod - change file mode bits

These "file modes" will be covered later, as well as common options.

Firstly, let's create a file in your home directory.

    wei2912@wei-lm-desktop ~ $ touch file
    wei2912@wei-lm-desktop ~ $ ls -l file
    -rw-r--r-- 1 wei2912 wei2912 0 Jun 24 15:26 file

Under here, you can see that we've created a file with the command [touch](/commands/UsefulTinyCommands.html#touch). Afterwards, we used the [ls -l](/commands/UsefulTinyCommands.html#listing_files) command to list out the file's details.

## Read, write, execute

Firstly, let's zoom into this:

    -rw-r--r--

Breaking it into parts:

    - rw- r-- r--

This is known as a **symbolic notation**.

## Symbolic Notation

In Linux, there're three types of modes applicable: Read, Write and eXecute. The common term "rwx" refers to read, write, execute.

Also, in Linux, there's a user, a group and others.

In this case, the first section, rw-, refers to the user being able to read and write. The second section, r--, refers to the user's group being able to read only. The third section, r-- as well, applies to others. It means that for others, the file is read only.

Here's a view of what it looks like:

    - rw-     r--     r--
       |       |       |
      user    group   others
       |       |       |
      read    read    read
      write

The first character tells a user which type of file this is. (d means a directory, - means a normal file).

Using 'rwxrwxrwx' is known as symbolic notation. Later, we'll cover an alternative way.

## User, group, others

Let's zoom into the second section now.

    wei2912 wei2912

This section means this belongs to user **wei2912** of group **wei2912**. To change this, [chown](/commands/Chmod&Chown.html#chown) is used. This will be covered later.

## Exercises

A directory's "ls -l" shows this output:

    drwx------  2 wei2912 wei2912  4096 Jun 17 18:19 bin
    
What are the permissions of this directory and who owns it?

**Answer:**

wei2912 owns the directory, only he can read write and execute. It is owned by the group wei2912.

## Numeric Notation

Sometimes, you might see someone state that a file has permissions "0777". What exactly does this mean?

Let's break it up into smaller parts agian.

    0777 -> 0 7 7 7

That doesn't seem to look like much, but each number signifies something. Let's ignore the first number for now.

Looking at the number 7, what do you think it means?

As from https://en.wikipedia.org/wiki/Filesystem_permissions under "Numeric Notation":

1. read is 4.
2. write is 2.
3. execute is 1.

In this case, 1 + 2 + 4 = 7. This 7 thus represents read, write and execute.

This is known as numeric notation.

As you've seen previously, the first parameter represented user, the second parameter represented group and the third, others. In this case, 0777 translates to -rwxrwxrwx.

## Exercises (again)

Translate these codes into symbolic notation:

1. 0777
2. 0755

**Answer:**

1. rwx rwx rwx
2. rwx rw- rw-

Now, on to the command chmod itself.

So, here's the basic syntax for chmod (according to manpages + some of what I add in):

    chmod [All/User/Group/Others][+/-][Read/Write/Execute] [file]

In chmod, there's an extra flag, "All". This flag includes user, group and others.

So, let's give you a look at what chmod commands typically look like.

    chmod a+rwx file

What does this mean?

This means, grant *rwx* permissions to all. *a* represents All, which includes User, Group and Others.

Now, take a look at this:

    chmod go-rwx file

What does this mean?

This means remove *rwx* permissions from *group and others*. This prevents others from looking at files and is typically used to store private data from non-root users.

## Here's another exercise!

A directory, bin/, has permissions 0777. You wish to remove write permissions from group and others. How'd you do this?

For this question, you need to supply two ways:

1. Using symbolic notation with chmod
2. Using numeric notation

Also, please note that in chmoding a whole directory, you should use the recursive flag.

    chmod -R blah blah blah

This means that changes apply to all directories and files contained within. To view which files will be changed, you can try "ls -R file/directory".

**Answer:**

1. chmod -R go-w bin/
2. chmod -R 0755 bin/

While doing the exercise, did you notice something between numeric and symbolic notation?

Let's try another exercise to find out.

## Again, an exercise!

File qwerty has permissions rwx rwx ---

What's the final file permissions after doing:

    chmod o+rx qwerty

**Answer:**

    rwx rwx r-x

Also, if file qwerty had permissions --- --- ---, what'd be the final file permissions?

**Answer:**

    --- --- r-x

**As you notice, using symbolic notation is relative to the file's permissions.**

Now, let's try with numeric notation.

    chmod 775 qwerty

What happens to the file permissions if qwerty had file permissions "rwx rwx ---" originally?

**Answer:**

    rwx rwx r-x

Now, what happens if qwerty had file permissions "--- --- ---" instead?

**Answer:**

    rwx rwx r-x 

So, now, you can see the difference.

**Using numeric notation is absolute and does not depend on the original file's permissions.**

Thus, by using numeric notation, you could save a lot of typing required for symbolic notation.

# chown

So, what's chown?

This command is used to change the ownership of a file/directory. As the manpage sums it up:

>  chown - change file owner and group

As you know from above, in Linux, there's a user and a group. chown sets a file to a specific user and group.

Here's the syntax:

    chown [user]:[group] file
    
Just like chmod, chown has a recursive mode used for directories. This means that changes apply to all directories and files contained within. To view which files will be changed, you can try "ls -R file/directory".

    chown -R [user]:[group] directory

That's about it. Chown is rather easy to use once you've mastered the concepts of users and groups.

## Exercises

Set folder "wireshark" to user wireshark and group wireshark. (PS: There's a Wireshark tutorial available at [Wireshark](/networking/Wireshark.html))

**Answer:**

    chown -R wireshark:wireshark wireshark/

# Conclusion

chown and chmod are commands that you'll definitely use at least once (and probably hundreds of times) in your Linux life. Master them well and you'll definitely benefit from it.
