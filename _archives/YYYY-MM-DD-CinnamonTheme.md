---
layout: post
title: How to make a Cinnamon Theme
category: desktop-environments
tags: [cinnamon, theme]
author: [Mimieam, wei2912, manu-27993]

status: draft
original: http://cinnamon.linuxmint.com/?p=144
---

Making a Cinnamon theme is both easy and fun, so let’s see how it’s done.

In this tutorial we’ll create a theme called “MyTheme” by modifying the default Cinnamon theme.

## Create the new theme
Go to your home folder and create a directory “MyThemeName”. Afterwards, create a directory “cinnamon” inside of “MyThemeName”. Finally, copy all the content from _/usr/share/cinnamon/theme_ into _Mytheme/cinnamon/_

    cd    
    mkdir -p MyTheme/cinnamon    
    cp -R /usr/share/cinnamon/theme/* MyTheme/cinnamon/    

## Get rid of files you don’t need

The file thumbnail-generic.png is not needed, and so you can delete it.

    cd
    rm MyTheme/cinnamon/thumbnail-generic.png

## Modify your theme

Open your file browser on .themes/Mytheme/cinnamon and have a look around. You’ll see the the following:         

png images which you can modify with GIMP        
svg vectors which you can modify Inkscape (or a text editor if you’re more into brute force search/replace features)        
css files which you can edit with a text editor (I personally recommend Geany for this)        
Test your changes as much as you can. To see what your theme looks like after you made changes to it you can either select another theme and reselect your theme in Cinnamon Settings, or restart Cinnamon by pressing “Alt F2″ and typing “r”.    

## Place your theme in ~/.themes:

    cd
    mkdir -p .themes
    mv MyTheme .themes/

Note: .themes is a “hidden” folder in your home directory, so you might have to click on “view->show hidden files” in your file browser. If the .themes directory doesn’t exist, create it.

## Select the theme

To select your theme, launch Cinnamon Settings, click on “Themes” and select “MyTheme”.            

## Tips and Tricks        

Here are a few things you should know:         

toggle-on-us.svg and toggle-off-us.svg are used when the locale is English. 

For other languages, toggle buttons use toggle-on-intl.svg and toggle-off-intl.svg. If you modify these, make sure to modify both the US and international versions.

thumbnail.png is the picture used by Cinnamon Settings to show a preview of your theme. Once you’re finished with your theme, make a screenshot with a similar size, overwrite thumbnail.png and make sure it looks nice in Cinnamon Settings.

overview.png and overview-hover.png should not be deleted. Users can decide whether or not they want the overview icon to appear, don’t take this choice away from theme by removing this from your theme.

cinnamon.css is what defines the look and feel of more or less everything. It starts with sections and themes definitions which are also found in Gnome Shell (to make it easy for artists to port their existing Shell themes to Cinnamon) and it then goes on with styles definitions specific to Cinnamon.

CSS is widely used on the Web, so there’s plenty of resources for it. Google things up to find out how to do a particular thing with CSS.

CSS supports color definitions in both Hex (typical HTML color codes) and RGB (which allows you to define transparency values). You can use GIMP to capture the Hex code for a particular color you see on the screen, or to use http://www.javascripter.net/faq/rgbtohex.htm and http://www.javascripter.net/faq/hextorgb.htm to easily translate color codes between the two.
