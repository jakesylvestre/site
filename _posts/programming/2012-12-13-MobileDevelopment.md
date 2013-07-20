---
layout: post
status: draft

title: Mobile Development
category: programming
tags: 
  - mobile
  - android
  - tablet
  - programming
  - sl4a
author: 
  - diabolist
  - wei2912

summary: Get started on developing from your tablet, using nothing more then a Tablet (Asus TF700T Transformer).

location: _posts/programming/2012-12-13-MobileDevelopment.md
---

I (diabolist) bought a Transformer Tablet and its keyboard attachment, as a cool product and hopefully a nice tool. The idea is to be able to development, modify, even test code in a mobile environment. It is far from perfect, but with patience you can get tools needed to begin development.

First off... I rooted my tablet. You don't *need* to, but I find it necessary for some tasks. *However*, this is *NOT* needed for the setup that I have. There are not many apps that have the flexibility or give you back the power of your terminal like [Terminal IDE](http://www.spartacusrex.com/terminalide.htm). You can install this app through Google's Play Store. Terminal IDE uses [Busybox](http://www.busybox.net/about.html), [bash (bourne again shell)](http://www.gnu.org/software/bash/), [ssh](http://www.openssh.org/), a few Java development tools, editors (nano, vim), even [git](http://git-scm.com/) (a little tricky to setup, but works), and you don't have to be root to use them.

<!--more-->

## Prototyping

Sometimes you'll be away from your laptop/desktop somewhere, over a friends house, at a coffee shop... All the sudden, you have this great idea for an app or just want to write a tool real quick. Instead of just writing it down somewhere and hoping to come around to it later... why not write your code on the fly?

[Scripting Layer for Android](http://code.google.com/p/android-scripting/), allows you to install your favorite scripting languages, like Python, Perl, Ruby (JRuby), JavaScript... which have access to most of the APIs your Android app would normally use. With this the sky is the limit, and it is even possible to run the interpreters in Terminal IDE without using the SL4A app. This is useful when you are running a script that uses arguments, because you can not give scripts arguments in SL4A. For a good example, I am writing this post in Markdown. Even though it is dead simple to write in, you still make mistakes and it would be nice to view it how others will see it, right?

### Using Perl(or any interrupter) from SL4A in Terminal IDE

We are going to use the Markdown.pl script, used to convert your markdown files into HTML, as an example of what can be done.

First, download and unzip Markdown. I have my folder in '/sdcard'. Now assuming that you have already installed the Perl interrupter for SL4A, we need to do a little hack...

    # allow ourselves to execute perl scripts
    /data/data/com.googlecode.perlforandroid/files/perl/perl "$@"

The above allows us to use the Perl interpreter form perlforandroid and execute scripts. Open up your favorite editor and write our little script then give it permissions to execute.
 
    vim perl
    chmod +x perl

Now you can move our script to the '~/system/bin' so that we can use it anywhere.

    mv perl ~/system/bin/

Go ahead and find our Markdown.pl script, and use it on a markdown file:

    perl Markdown.pl myfile.md

You'll see it just spit out text in html... So we just want to redirect it into a file like so:

    perl Markdown.pl myfile.md > myfile.html

Now you can find your file in your filemanager and open it with HTMLViewer  :-)

This method has also been done for Python, and I'm sure can be used for others. Now you can run most of your scripts on your Android device.

## Git

One thing you'll want is a way to easily manage your software. Git does this, and is widely used, for good reason. We have it with Terminal IDE and we can set it up to do what we need.

[This guide](lox-o-drome.blogspot.com/2012/08/damgit-how-to-painfully-set-up-git-on.html) is what I used to setup git, and I am just going to summarize it here.

### SSH public key

We will need to use SSH to connect to Git repositories because Terminal IDE doesn't seem to like __https://__. That means creating a public ssh token. We will use 'dropbearkey' to create a password-less pair for our servers. In Terminal IDE run:

    mkdir ~/.ssh (if you don't already have it)
    dropbearkey -t rsa -f ~/.ssh/id_rsa

Now we want to print the public token to a file so we can use it:

    dropbearkey -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub (open up your text editor and remove the first line: 'Public key portion is:')
    cp ~/.ssh/id_rsa.pub /sdcard/ (copy here so we can find it)

Depending on where your repositories are, you'll need to add your public token accordingly

- If our repos are from Github, then we simply login to our account with our browser, go to Account Settings, SSH Keys, Add SSH Key, and copy the contents of our id_rsa.pub into 'Key' textbox.
- If we are repos are on a private server, well need to add the contents of id_rsa.pub to our Servers '/home/username/.ssh/authorized_keys'

WARNING: the above will _NOT_ work until we finish setting up Terminal IDE! Please read on!

Now we need to tell Terminal IDE were our public key is. Using your favorite editor, open ~/.bashrc and add the following at the bottom of the file:

    alias ssh='ssh -i ~/.ssh/id_rsa'

Next well need to create a file in ~/bin named ssh-git with the following content:

    #!/data/data/com.spartacusrex.spartacuside/files/system/bin/bash
    exec ssh -i ~/.ssh/id_rsa "$@"
    
The first line has a shebang, indicating the environment. This will be bash, which isn't in the default locations.

Now make it executable:

    chmod 755 ~/bin/ssh-git

... and now append the follow into ~/.bashrc

    export GIT_SSH=~/bin/ssh-git

### Configuring Git

OK, now that we are finished playing with that, don't forget to configure Git! Unfortunately, doing this the conventional way will not work due to config issues. However we can still get it to display the correct information. Once again, open up '~/bashrc' in our text editor and add these to it:

    export GIT_AUTHOR_NAME="Your Name"
    export GIT_AUTHOR_EMAIL="email@email.com"
    export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
    export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

Pick a place to get your project. I decided to use my Removable SDCard, for portability and space.

    cd /Removable/MicroSD/
    mkdir development && cd development

Now! Lets get our project! Because we are going to be using SSH to grab our projects, cloning is going to be a tad different: (You will need to authenticated with Github first! (ssh -T git@github.com))
    
    git clone ssh://git@github.com/projectname

We will need to do a little hack so that we can push and pull form our repositories. It'll complain that we do not have 'git-merge'... so we will create it:

    cd ~/system/bin
    ln -s git git-merge

Now, you should be able to push and pull without an issue, and now can work on your projects on the go. Another tool I use besides the editors in Terminal IDE, is Ted. It is simple, free, and does what I need.
