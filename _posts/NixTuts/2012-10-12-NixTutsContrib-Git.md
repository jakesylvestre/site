---
layout: post
title: Using Git to Contribute
status: book
category: NixTuts

bookurl: /NixTuts/NixTutsContrib.html
book: Contributing to NixTuts

summary: In this tutorial we'll teach you how to grab the source repository of NixTuts. This applies to many Git repositories hosted on GitHub.

location: _posts/NixTuts/2012-10-12-NixTutsContrib-Git.md
---

This tutorial will show you the basics of using Git and will teach you how to obtain and modify the source code of NixTuts. The main concepts, ideas and commands shown here are alo applicable to many other Git projects on GitHub and around the Internet. This tutorial will also introduce to you other tools for editing Git repositories.

## Using git

As you should know, Git is a distributed version control system. It is used very widely for many projects, ranging from the [Linux kernel](http://www.kernel.org) to [our own NixTuts repository](https://github.com/linuxtuts/linuxtuts.github.com). If you haven't already installed Git, please [do so](http://git-scm.com/downloads) and [configure it](https://help.github.com/articles/set-up-git) as well. If you are not an admin/collaborator, you will have to fork our repository on GitHub. Just proceed there and click the Fork button. You might also want to rename your forked repository. After doing so, you can proceed to clone the repo into your computer.

For admins/collaborators, run this:

    git clone https://github.com/linuxtuts/linuxtuts.github.com.git nixtuts

If you have forked our repository instead, run the following command, replacing the necessary parts:

    git clone https://github.com/yourUserName/yourRepoName.git nixtuts

That will create a folder called NixTuts, and will copy the contents or our repo into it. You can view all the files in the folder by entering it and listing its contents:

    cd nixtuts
    ls

Now you can start contribtuing by adding/editing the files.

To add a new file, simply create the file, and stage it:

    touch filename.md
    git add filename.md

After you edit an existing file, you also have to stage it:

    git add filename.md

To check out what you have changed, run this:

    git commit

Once you have added the changed files, you can simply create your commit
and short message about the commit with:

    git commit -m 'changed whatever i changed'

Of course, if you want to add all locally changed files… use this:

    git commit -a -m 'changed whatever i changed'

And then you push… but! Not so fast.

Join us in the IRC channels specified on the [http://nixtuts.info/pages/about.html](About) page where you can be
informed by the GitHub bot if there have been any other changes. If
there are, you are urged to do a pull first, to update changes from the
online GitHub repo.

However, this might cause a conflict, so best to do it before, or have a
backup copy of your changes ready to be put back over your local github
repo after the pull and before you commit and push.

If you’re in the chat though, you get to see when you need to pull, to
keep your local cloned copy of it up to date, so you’re not trying to
regress the online one when you push.

So, how to pull, easy peasy:

    git pull

Then push that commit to the online repo with:

    git push origin master
    
GitHub uses username-password authenciation, which is recommended. Type in your username and password.

If there’s a problem with this, try this command:

    git remote set-url origin https://github.com/linuxtuts/linuxtuts.github.com.git

In brief, a suggested workflow patern is usually:

-   First you clone, once
-   Then: pull
-   Make changes
-   Commit with a nice message
-   Push
-   Repeat from pull onwards. the more the better. ;)

If you’re not a collaborator yet, you can fork the repository on GitHub,
make your changes, and make a pull request to use. If we accept it, we
will add you in as a collaborator.

__We will make it easier to contribute soon if you're not a collaborator!__

<!--more-->

#Web Interface

You can also use the web interface directly at github.com

In your web browser, visit [https://github.com/linuxtuts/linuxtuts.github.com](https://github.com/linuxtuts/linuxtuts.github.com) and browse the files. Click on one and when it opens up, click edit from the top bar directly above the file’s content.

## Other git tools

As you can see in [\"Git Interfaces, frontends and tools\"](https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools), there are more git frontends than you are likely to thoroughly research in a lifetime.

There is [Smartgit](http://www.syntevo.com/smartgit/index.html) too which multiple members of our team uses.

If you're too lazy to use Git, try out [prose.io](http://prose.io). You can look at the link just below this post and give a try at editing this post!
