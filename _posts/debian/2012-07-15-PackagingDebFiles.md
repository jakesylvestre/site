---
layout: post
status: post

title: Packaging deb files
category: debian
tags: 
  - debian
  - deb
  - package
author: 
  - Mimieam
  - wei2912

summary: Deb files are great. They don’t include all the dependencies, they download from repositories. This makes them rather appealing as lightweight. Another strong point is the ease which anyone can install them with. That’s not all though – deb files are incredibly simple to package. With just a bit of work, you can package one in a matter of minutes!

location: _posts/debian/2012-07-15-PackagingDebFiles.md
---
<!--more-->

## The structure of a deb package

It seems that a deb package is a package that contains many wonders we can’t read or understand. That is definitely not true. The structure of a deb package is:

    DEB source
    |
    -> DEBIAN - Manifest and control files
    -> other stuff

In __other stuff__, you treat the deb file like a root file system. For example, let’s say you want to put a script, “rotate-wallpaper”, in /usr/bin. Here’s how you do it:

    DEB source
    |
    -> DEBIAN - Manifest and control files
    -> usr
        | -> bin
    | -> rotate-wallpaper - the script!

That’s how easy it is!

## Going inside the mysterious _DEBIAN_ directory

Well, I’m just going to show you the necessary files. Any other files you require, you’ll have to research

    DEB source
    |
    -> DEBIAN - Manifest and control files 
       |
       -> control - Manifest/Control file
       -> preinst - Script that runs before the installation of the package
       -> postinst - Script that runs after the installation of the package
       -> prerm - Script that runs before the removal of the package
       -> postrm - Script that runs after the removal of the package

It may look complicated, but I don’t think you’ll need preinst, postinst, prerm and postrm often for your basic DEB packages. Instead, we’re just going to concentrate on the control file. If you ever need those 4 scripts, just write them like how you do with shell scripts.

## Writing the control file

Here’s what in the control file for one of my packages!

    Source: backgrounds
    Section: unknown
    Priority: optional
    Maintainer: wei2912
    Package: backgrounds
    Version: 1.3
    Architecture: all
    Description: Backgrounds to keep you all occupied!
    Installed-Size: 124000

Copy and paste this. Change the values accordingly (leave Priority as optional and Section as unknown). For “Mantainer”, put your nickname and an email after it, just like what I did above.

For Package and Source, put the same thing. For version, put the version of the software. For architecture, check first if it is amd64 or i386, or ALL. Add in a description, give the installed size (in kb) and you’re done!

## Adding dependencies if needed

Dependencies are what software require to run. All packages that you add must be separated by space. To add them to your control file, just add this:

    Depends: packages_you_need
    Recommends: packages_that_a_user_may_want_to_install_along_with_this_package
    Suggests: packages_that_contains/is_related_to_your_package
    Conflicts: packages_that_cause_this_to_not_work_if_installed
    Replaces: same_as_conflict,_more_commonly_used_than_Conflicts
    Breaks: packages_that_must_not_be_installed_together_with_your_package
    Provides: packages_that_your_package’s_function_provides

## The final step: Compiling the package

Now, move to the directory outside of your source package. I built a script that should tell you how to use the command. This script is to be put in the directory containing the DEB file source. Feel free to use it!

{% prism bash %}
#!/bin/bash

ls
echo “Please type the name of the source directory shown above.”
read dir
echo “Please type the name of the package.”
read package
echo “Please type the version of the package.”
read version 
dpkg -b ./$dir $package-$version.deb
{% endprism %}

There! package-version is just a custom in creating deb packages, they’re simply the name. You can put anything you want, including adjzoighficouazgdiuyagnifdzxagl8m, but whether it is useful to the user it’s up to you.

## The end

Now, you’ve learnt how to create a deb package. One more skill for you! Use this wisely to help open source projects create deb packages. You can also use this for your own software if you have any. Upcoming soon will be... how to create your own Launchpad PPAs :D (only for Ubuntu)

