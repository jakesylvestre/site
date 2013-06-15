---
layout: post
title: Remastering with mintConstructor
category: remaster
tags: [remaster]
author: [wei2912]

status: draft

sources: ["http://community.linuxmint.com/tutorial/view/918"]

summary: mintConstructor is a pretty handy tool which helps with remastering. It's something like "editing" the contents of an ISO just like you would do with a normal Linux distro, by using "chroot". 
---

Install the package "mintconstructor" from the Linux Mint repositories. You can add this to /etc/apt/sources.list:
    
    deb http://packages.linuxmint.com maya main backport import romeo universe upstream
    deb-src http://packages.linuxmint.com maya main backport import romeo universe upstream

Open a terminal and type this:

    sudo /usr/lib/linuxmint/mintConstructor/mintConstructor.py

In the mintconstructor window that opens, choose a directory for the ISO in the "Directory" field. Select the "New project" option. Finally, click the browse button and select the ISO file.

#Modify the content of the ISO

All modifications are done via the mintconstructor chroot terminal. To access the content of the ISO and modify it, click on the "Open a chroot terminal" button.

In this chroot terminal, you can type commands, install and remove packages and this will have a direct impact on the ISO, its content and the content of the system which installs itself from the ISO to the Hard drive during the installation.

Once you're finished making modifications, make sure to clean up with the following commands:

    aptitude purge ~c
    aptitude unmarkauto ~M
    apt-get clean; rm -rf /var/cache/debconf/*.dat-old; rm -rf /var/lib/aptitude/*.old; rm -rf /var/lib/dpkg/*-old; rm -rf /var/cache/apt/*.bin; updatedb
    history -c
    rm /root/.bash_history
    rm /root/.nano_history
    history -c

To rebuild the new iso, close the chroot terminal. Click next and give your ISO a description. Click next once more and you're done! Wasn't that easy?

