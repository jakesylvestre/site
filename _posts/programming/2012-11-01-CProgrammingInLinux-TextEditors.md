---
layout: post
title: C/C++ Programming in Linux - Text Editors
category: programming
tags: [programming]
author: [manu-27993, wei2912]

status: draft

summary: Many C/C++ Programming IDEs are not available for download on Linux. Here, we cover the solutions in Linux.

location: _posts/programming/2012-11-01-CProgrammingInLinux-TextEditors.md
--- 

Here are two solutions you could use:

1) C/C++ Programming using Gnome Terminal, Text-Editors and gcc command.

2) C/C++ Programming using your favorite MS-DOS based IDE in DosBox.

<!--more-->

##C/C++ Programming using Gnome Terminal, Text Editor and gcc command:


###Using VI Text Editor:

(This section assumes that you have installed VI Editor, gcc and g++)

1) Press Alt+F2, type gnome-terminal (or konsole in KDE) and press enter(return key). cd to the directory to which you want to store your C Programs.

    cd Documents

2) Type the Filename of your program. Use .c extension for C Programs and .cpp for C++ Programs (applicable throughout this tutorial page)

    vi filename.c

3) You now enter the VI Editor. To start writing your Program, press Insert (Ins) key and start typing.
Once you are done, Press Escape (Esc) key, type the following without quotation marks to save and exit out of the VI Editor.

    :wq 

You now come back to the Terminal screen. 

4) To compile your C/C++ Program, use the gcc command with -o flag between the program filename and the executable filename. 

    gcc filename.c -o output_filename.out

5) If there are any errors in the program, it will be displayed. You can go back to your program for editing and correct your errors by repeating steps starting from 2nd step again.
If there are no errors, an output file by name "output_filename.out" will be created.
To test the output, type “./output_filename.out” without the quotation marks. The output will be displayed on the terminal screen.

    ./output_filename.out

Note: typing "gcc filename.c" alone will result in an output file “a.out”. To test this output, type:

    ./a.out

Advantages of this method:

- Parallel programming can be performed which Linux and Unix based OSes are so good at doing.
- You don’t have to leave the Terminal screen for anything once opened.

###Using GUI based Text Editors like Gedit/Kate:

(This section assumes that you have installed gedit or kate, gcc and g++)

1) Open your Home folder, navigate to the Templates folder. Create a new file called “C Program.c”. Now you have created a Template for C Program which can be used anywhere to create a new C Program file.

2) Navigate to the folder in which you want your C Program to be created, right click, select Create New Document > C Program.c

3) Rename it to your liking, let’s assume "filename.c"

4) Double-click your file, and start editing in Gedit/Kate, save your program and exit.

5) Press Alt+F2, type gnome-terminal (or konsole in KDE) and press enter(return key).

6) cd to the directory in which you have stored your C Program.

    cd Documents

7) Type this to compile your C/C++ Program:

    gcc filename.c -o output_filename.out

8) If there are any errors in the program, it will be displayed. You can go back to your program for editing and correct your errors by repeating steps starting from 4th step again.
If there are no errors, an output file by name "output_filename.out" will be created.
To test the output, type “./output_filename.out” without the quotation marks. The output will be displayed on the terminal screen.

    ./output_filename.out

Note:
1) Typing gcc "filename.c" alone will result in an output file “a.out”. To test this output, type ./a.out
2) Templates do not exist in KDE (Ignore the first 3 steps), hence program files have to be created manually each time. 

Advantages of this method:

- Parallel programming can be performed which Linux and Unix based OSes are so good at doing.



##C Programming using your favorite MS-DOS based IDE in DosBox:

(This section assumes that you have DosBox and the required IDE (like Turbo C/C++) installed.)

1) Copy the contents of the installed IDE (from Windows) to your Home Folder and rename the folder to C (just for ease).

2) Run DosBox once and exit out of it. This will create “.dosbox” folder in your home folder. Open that folder and double click on dosbox-x.xx.conf file.

3) Go to the last line and add these lines, save and exit.

    mount C: ~/C
    C:

4) Run DosBox again and type tc.exe (or whatever the IDE name is). This will open your favorite IDE for editing. Type, compile and test your program in it.

Advantages:

- You can use your favorite IDE for C/C++ Programming.

Disadvantages:

- Parallel Programming abilities of Linux is not accessible.

So, what are you waiting for? Test your C/C++ Programming capabilities on your favorite Linux distro!
