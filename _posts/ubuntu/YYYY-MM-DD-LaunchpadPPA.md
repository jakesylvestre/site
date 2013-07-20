---
layout: post
status: draft

title: Starting a Launchpad PPA
category: ubuntu
tags: 
  - launchpad
  - ppa
  - ubuntu
author: 
  - wei2912

summary: Launchpad PPAs are one of the ways Ubuntu uses to make life easier for common users, who don't want to copy whole lines of text into their /etc/apt/sources.list.

location: _posts/ubuntu/YYYY-MM-DD-LaunchpadPPA.md
---
Instead of using a debian repository, this is a MUCH better way:

    sudo add-apt-repository blahblahblah

<!-- more -->

## Building up a DEB file/source package
Check [Packaging deb files](/posts/PackagingDebFiles.html) first, a tutorial I wrote about creating DEB packages. The DEB package you have is required for uploading to a PPA.

## Sign up for a Launchpad account!
[https://login.launchpad.net/+new_account](https://login.launchpad.net/+new_account) - There you go to creating a new account.

## Signing the Ubuntu Code of Conduct

Before you do anything, you need to sign the Ubuntu Code of Conduct first, in order to create PPAs.

### Generating the OpenGPG key

Information is taken from: [https://help.ubuntu.com/community/GnuPrivacyGuardHowto#Using_GnuPG_to_generate_a_key](https://help.ubuntu.com/community/GnuPrivacyGuardHowto#Using_GnuPG_to_generate_a_key)

Type this:

    gpg --gen-key

You'll see this screen:

    Please select what kind of key you want:
    (1) RSA and RSA (default)
    (2) DSA and Elgamal
    (3) DSA (sign only)
    (4) RSA (sign only)

Select (1).

    RSA keys may be between 1024 and 4096 bits long.
    What keysize do you want? (2048) 

Use the default. (type 2048)

    Please specify how long the key should be valid.
    0 = key does not expire
    <n>  = key expires in n days
    <n>w = key expires in n weeks
    <n>m = key expires in n months
    <n>y = key expires in n years
    Key is valid for? (0) 

Use the default too (type 0).

    Is this correct? (y/N) 

Check through your info and type the answer accordingly.

    You need a user ID to identify your key; the software constructs the user ID from the Real Name, Comment and Email Address in this form:
    "Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>"
    .
    .
    .

Go through the rest of the process...

    Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? 

Type the answer accordingly too.

Now, enter your passphrase twice. Then it comes to an epic period:

    We need to generate a lot of random bytes. It is a good idea to perform some other action (type on the keyboard, move the mouse, utilize the disks) during the prime generation; this gives the random number generator a better chance to gain enough entropy.

Move the mouse, run some nifty fork bombs (just kidding), mount and unmount drives, type random stuff etc. (Best is to write a tutorial during that time and send it to us) Hopefully, you'll end up with something random.

### Obtaining crucial information

Go to your user page and click on the edit button of "OpenPGP keys". Type this command in a terminal:

    gpg --fingerprint

You'll see a message similar to this:

    pub 1024D/12345678 2007-01-26
    Key fingerprint = 0464 39CD 2486 190A 2C5A 0739 0E68 04DC 16E7 CB72
    Geoffrey Hayes (My OpenPGP key) <geoffrey@bungle.com>
    sub 2048g/ABCDEF12 2007-01-26

Make sure you don't lose this. DO NOT PASTE IT ANYWHERE ONLINE

### Publishing your OpenPGP key to Ubuntu Keyserver

Copy the part after "pub 1024D/" (12345678). That is your pub ID. Use it in this command:

    gpg --keyserver keyserver.ubuntu.com --send-keys 12345678

If successful, GPG will display a message similar to:

    gpg: sending key 12345678 to hkp server keyserver.ubuntu.com

### Importing your key

Copy the key fingerprint (0464 39CD 2486 190A 2C5A 0739 0E68 04DC 16E7 CB72). Make sure it's the correct key - you may have other keys.

Now, import your fingerprint.

You should see this:

    A message has been sent to YOUREMAIL@EMAIL.com encrypted with the key 1024D/12345678. To confirm the key is yours, decrypt the message and follow the link inside. 

<p class="notice">Never reveal your fingerprint.</p>

### Decrypting the message

You'll recieve an email from Launchpad in the email account you used for your Launchpad account. At the end of the message, you'll see something similar to this:

    -----BEGIN PGP MESSAGE-----
    Version: GnuPG v1.4.10 (GNU/Linux)
    
    hQEMA7ziL1zS+sqCAQf9En3dAHsXXCDfxYlBjpMbh4nhYPHbad8a6TCPfRcTOJEy
    N8SOm2kJzKKIoL8LpbdMf1vwCMcagAVNxgnslUfIyzyQkkjZu7xkltrip6icjQXC
    px1wUVkBdDMtr5QkFmBnstGKi/j6HNMDJeg/68gPFwyco/u02+2FQ1M1lmJYNziK
    yG2+GobJnr+3NBv+m67Fojw4O5TPxZTPG7cmFaixOuU1LrHFE2akS54yNTH314du
    FwtD5G+tLXsNE2/yhFzDIE6ESuk9QspWRadxpAaDiuOUJVpsd/jXGwJA0zVnTOaG
    ZWvEDzlb7hgCXhwRG28KcEDn7hIamKtwwGA4+O/HmNLAtgEkKH3OGok2EjYDex4F
    44P2FRkelZwgW69KLPjzHVRWZAaVN5+Jje7M7Azboh8+G/+eZhCmiM8KkpEIF8/H
    v7t1M+hSn+xZ3O9Z7aA2xRSYOe/ibhGVtOO1YonS7JT96hXRWOane3ewY9TnkX+Q
    tQNkTlNIBf9jRXNYQ+1rETVpJjirjKSPmX6EWA4MaP/s7ohaqOLyriGjmn4/GXOF
    ZZ7m8GDduLumPW1E+D/GjtK7hxWvRSUOBdK9Nj/kNUM5nlxpMGQvbIdymeCvpYF+
    ytmJ4KKbnoBRgXvlsSSW4dyLJPygkzz0M3KjBnw4mMstRXxw27UIQLkwgP4xFAIi
    0CT8aYeZT5yb8x1TWhjicqy5mggCK69yhu8TMc7k4LHkZUehpXHqLXlSIyTI42ZN
    +gC2uauUQK1MVt5EQ3qG6/0GXdtGmNjyMgHSkoeIuOo0hQwWV08sBJircVVSSyhK
    fVe+Fi+hcX90ytzVlmWwTml7cofxTHdD
    =g/qT
    -----END PGP MESSAGE-----

Copy and paste the whole PGP message into "message.pgp". Now, type this:

    gpg -o output.txt message.pgp

Type in the passphrase. Once it ends, type:

    cat output.txt

That's what the message is.

An example:

    Here are the instructions for confirming the OpenPGP key registration that we
    received for use in Launchpad.
    
    Requester details:
    
        User name    : aszdcsdc
        Email address: blah@email.com

    Key details:
    
        Fingerprint : asdoign9ixngao8f8ecslozmlscklnoboung8ofexanwz8cgva9im
        Key type/ID : aouzodc9agncm89sogc
    
    UIDs:
        blah@email.com
    
    Please go here to finish adding the key to your Launchpad account:
    
        https://launchpad.net/token/iouagn8zc8ongso8gzc8ms

Go to the link specified below. Click continue. You're finally done with importing!

### The Ubuntu Code of Conduct

Go to [https://launchpad.net/codeofconduct/1.1/+sign](https://launchpad.net/codeofconduct/1.1/+sign)

Download the [Ubuntu Code of Conduct](https://launchpad.net/codeofconduct/1.1/+download) first. Read it (of course). Then, type this:

    gpg --clearsign UbuntuCodeofConduct-1.1.txt

Type in your passphrase. You'll see an encrypted version at:

    UbuntuCodeofConduct-1.1.txt.asc

Copy the file contents and paste it in. You're finally done! (wasn't that hard?)

