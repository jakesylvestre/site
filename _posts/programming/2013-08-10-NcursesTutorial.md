---
layout: post
status: draft

title: Ncurses Tutorial
category: programming
tags: 
  - programming
  - c++
  - ncurses
  - console
  - codeblocks
author: 
  - Paradux
  - wei2912

summary: Have you ever wanted to make a console application or game in C++? Well, Ncurses is the solution! This short tutorial will teach you how to setup this library on CodeBlocks and will teach you some basic features.

location: _posts/programming/2013-08-10-NcursesTutorial.md
---

This tutorial will consist of 2 parts:

1) Installing Ncurses on CodeBlocks

2) Showing some basic features

After this tutorial, you will be able to create your own console application using Ncurses.

<!--more-->

## Installing Ncurses on CodeBlocks

First of all, you will need the CodeBlocks IDE (Integrated Development Enviroment). To install, simply go to your package manager and search for the latest version of CodeBlocks. Or you can open up a terminal and use aptitude:

    sudo apt-get install codeblocks

Next up is getting Ncurses. The latest version is available on: [http://ftp.gnu.org/gnu/ncurses](http://ftp.gnu.org/gnu/ncurses) (At the time of writing it is ncurses-5.9.tar.gz), put it in your Home folder.
When you have downloaded the tarball extract it with tar:

    tar -xzvf ncurses-5.9.tar.gz

Now is the time to configure and make the file, go to the extracted ncurses-5.9 folder in the terminal and run these commands:

    ./configure
    make
    sudo make install

Now comes the last part, configuring CodeBlocks to look for Ncurses. Start up CodeBlocks and go to Settings > Compiler and debugger, then go to the tab named 'Linker settings' and add /home/*yourname*/ncurses-5.9/lib/libncurses_g.a and /home/*yourname*/ncurses-5.9/lib/libncurses.a 

![Linker Settings](/img/programming/NcursesTutorial/linker_settings.png "Adding the Ncurses linker file")

Go to the next tab called 'Search Directories' and add /home/*yourname*/ncurses-5.9/ to Compiler, Linker and Resource compiler.

![Compiler](/img/programming/NcursesTutorial/compiler.png "Adding the main Ncurses folder to Compiler.")

![Linker](/img/programming/NcursesTutorial/linker.png "Adding the main Ncurses folder to Linker.")

![Resource](/img/programming/NcursesTutorial/resource.png "Adding the main Ncurses folder to Resource Compiler.")

You are now done with part 1!

## Ncurses' basic features

To test if it all works, we will compile the mandatory Hello World program.

    #include <ncurses.h>
    int main()
    {	
    	initscr(); /* Start curses mode  */
    	curs_set(0); /* Makes the cursor invisible */
		printw("Hello World !!!"); /* Print Hello World */
    	refresh(); /* Print it on to the real screen */
    	getch(); /* Wait for user input */
    	endwin(); /* End curses mode */
    
    	return 0;
    }

So let's go through this short piece of code. 

The first function *initscr()* is to initiate Ncurses, you will need to put this function in every source code that uses the Ncurses library. This function initializes the curses system and allocates memory for our present window (called stdscr) and some other data-structures. 

*printw(string)* will output a string to an imaginary window. This brings us to *refresh()*. When we called *printw()* the data is actually written to an imaginary window, which is not updated on the screen yet. The job of printw is to update a few flags and data structures and write the data to a buffer corresponding to stdscr. In order to show it on the screen, we need to call *refresh()* and tell the curses system to dump the contents on the screen. This function gives you the ability to make multiple changes to the output and display it whenever you want. 

*endwin()* will terminate Ncurses mode and frees the memory used.

Now, there are more functions that output plain-text to the screen: 

    printw(string); /* Print on stdscr at present cursor position */
    mvprintw(y, x, string); /* Move to (y, x) then print string     */
    wprintw(win, string); /* Print on window win at present cursor position in the window */			   
    mvwprintw(win, y, x, string); /* Move to (y, x) relative to window co-ordinates and then print*/
    mvaddch(row,col,ch); /* Move to (y,x) relative to window co-ordinates and then print a character */

As you might have noticed, the function *wprintw(win, string)* can print at the present cursor position in a window. You can do some pretty cool stuff with windows and panels, but I will go deeper into that in some other tutorial (If you are that desperate to learn how windows work, try the [Ncurses HOWTO guide](http://tldp.org/HOWTO/NCURSES-Programming-HOWTO/windows.html).

Moving on from this, it is also possible to give text a foreground and background colour, underline it and to make it bold. Take a look at the next code:

    #include <ncurses.h>
    int main()
    {	
		initscr();
		start_color(); /* Be sure not to forget this, it will enable colors */
		init_pair(1, COLOR_RED, COLOR_CYAN); /* You can make as much color pairs as you want, be sure to change the ID number */
		init_pair(2, COLOR_YELLOW, COLOR_GREEN);
		attron(A_UNDERLINE | COLOR_PAIR(1)); /* This turns on the underlined text and color pair 1 */
			printw("This is underlined red text with cyan background\n");
		attroff(A_UNDERLINE | COLOR_PAIR(1));
		attron(A_BOLD | COLOR_PAIR(2));
			printw("This is bold yellow text with green background");
		attroff(A_BOLD | COLOR_PAIR(2));
		refresh();			
		getch();			
		endwin();		
		return 0;
    }
    
In this last part of the tutorial I will show you how to interface with the keyboard. This next application I wrote is self-explanatory:

    #include <ncurses.h>
    int main()
    {
        int x = 5;
        int y = 5;
        int ch; /* Key input variable */
        initscr();
        curs_set(0);
        keypad(stdscr, TRUE);		/* We get key input	from the main window */
        noecho(); /* Don't echo() while we do getch */
        while(1)
        {
            mvprintw(y, x, "X");
            ch = getch();
            if(ch==KEY_DOWN)
            {
                        y++;
                clear();
                }
                if(ch==KEY_UP)
                    {
                y--;
                clear();
            }
            if(ch==KEY_LEFT)
            {
                x--;
                clear();
            }
            if(ch==KEY_RIGHT)
            {
                x++;
                clear();
            }
            refresh();
        }
        endwin();			
        return 0;
    }	

That's the end of this short Ncurses tutorial, I hope you've learned the basics. Now go write your own console application! For more information see the [HOWTO guide](http://www.tldp.org/HOWTO/NCURSES-Programming-HOWTO/index.html) and [http://pubs.opengroup.org/onlinepubs/7908799/xcurses/curses.h.html](http://pubs.opengroup.org/onlinepubs/7908799/xcurses/curses.h.html) for more information.
