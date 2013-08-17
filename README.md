# [NixTuts](http://nixtuts.info)

NixTuts is a site filled with tutorials. We aim to help *nix users, spread knowledge of *nix and help the Open Source/Free Software community!

[![Visit our IRC channel](https://kiwiirc.com/buttons/irc.spotchat.org/NixTuts.png)](https://kiwiirc.com/client/irc.spotchat.org/?nick=kiwi_guest|?#NixTuts)

## Build System

We're going to use Travis-Ci for our build system, at [https://travis-ci.org/nixtuts/site](https://travis-ci.org/nixtuts/site).

It's still in progress at the travis-ci branch.

## Cloning the repository

Firstly, you follow the standard procedure for repositories:

	git clone https://github.com/nixtuts/site
	
Then, we'll need to clone the `git submodule` located at [binaries](https://github.com/nixtuts/binaries).

    git submodule init
    git submodule update

After this, when you wish to pull changes from the binaries/ folder:

	git submodule foreach git pull origin master
	
You'll need to pull changes, then make a commit with the new update.

## Archives

Posts that are suspected of copyright violations or are irrelevant are to be put in _archives. You may use them for reference purposes or attempt to rewrite them.

## Dependencies to build

Follow instructions at: http://nokogiri.org/tutorials/installing_nokogiri.html (but don't install nokogiri)

Once you're done, install the plugins required.

    jekyll
    jekyll-less
    
## Modernizr

We use a customized version of Modernizr. The current features are selected in the [customized builder](http://modernizr.com/download/):

* Modernizr.load (yepnope.js)

If you need any more features, consult nixtuts.supp0rt@gmail.com
