---
layout: post
status: draft

title: Hashcat Basics
category: security
tags: 
  - security
  - hashcat
  - cracking
  - password
author: 
  - wei2912

summary: Hashcat is a nifty tool for testing out passwords. In this tutorial, we'll give you a guide through the basics of Hashcat.

location: _posts/security/YYYY-MM-DD_HashcatBasics.md
---

***Before we start, I'd like to warn you that attempting to obtain passwords is illegal. The content provided is meant only for educational purposes.***

Hashcat is a tool often used to test out passwords. Firstly, I'll explain how passwords are stored in a typical Linux system, then show how Hashcat is different from other password crackers.

# Downloading Hashcat

Let's obtain a copy of Hashcat first. In this tutorial, we'll be using the standard *[hashcat](http://hashcat.net/hashcat/)*.

Hashcat uses .7z extraction, so to extract it:

    7z x file.7z

Once it's extracted, *cd* into the directory. That's the end of the installation!

# Testing out Hashcat

Let's see if Hashcat works.

Once you're inside the Hashcat directory, execute the following command:

    ./hashcat-cli64.bin -m 0 examples/A0.M0.hash examples/A0.M0.word

If using 32 bit:

    ./hashcat-cli32.bin -m 0 examples/A0.M0.hash examples/A0.M0.word

You'll see a huge jumble of text pop up. The bottom part is what matters:

    Input.Mode: Dict (examples/A0.M0.word)
    Index.....: 1/1 (segment), 102 (words), 2769 (bytes)
    Recovered.: 102/102 hashes, 1/1 salts
    Speed/sec.: - plains, - words
    Progress..: 102/102 (100.00%)
    Running...: --:--:--:--
    Estimated.: --:--:--:--

As seen here, we've successfully cracked all hashes. But how did we do it? Let's delve in further.

## Flags

Looking at our first command, let's break it up into pieces.

    -m 0
    examples/A0.M0.hash
    examples/A0.M0.word

The first part, *-m 0*, sets the hash to MD5; what *examples/A0.M0.hash* is hashed with.

The second part, *examples/A0.M0.hash*, is the hashfile and the third part, *examples/A0.M0.word*, is our dictionary.

# Let's try to crack a couple of passwords

Download [SHA512.hash](/files/HashcatBasics/SHA512.hash) and place it in your hashcat directory.

This time, we won't be using a Straight attack, but a Permutation attack. This uses a rules file and a dictionary. Both are combined together to form a more extensive attack.

I'll give you a challenge to crack the passwords, after handing you a command.

    ./hashcat-cli64.bin -m 1800 -r ./rules/rulefile SHA512.hash ./dict/dictfile

There're multiple choices for a rulefile, available in *rules/*. A rulefile manipulates a string from a dictfile to provide multiple combinations. For example, "password" may be l33tify into "passw0rd".

For a dictfile, try these:

* [500 worst passwords](http://downloads.skullsecurity.org/passwords/500-worst-passwords.txt.bz2)
* [370 Banned Twitter Passwords](http://downloads.skullsecurity.org/passwords/twitter-banned.txt.bz2)
* [RockYou](http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2)

These provide text files containing strings which may be useful to you when cracking passwords.

# Now that you've learnt how to crack passwords quickly...

Use them wisely to test passwords and enhance them/warn users, but *please do not use them in order to gain access to a system*.
