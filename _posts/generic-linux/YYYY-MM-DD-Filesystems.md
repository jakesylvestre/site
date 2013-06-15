---
category: generic-linux

location: _posts/generic-linux/YYYY-MM-DD-Filesystems.md
---

STUFF ABOUT FILESYSTEMS

# Mounting filesystems remotely

Sometimes you may need to access a filesystem remotely. We'll elaborate on a few ways, that way you can decide which is the best soultion for you.

##SSHFS

Requirements: SSHFS on the local system (and [FUSE]("http://fuse.sourceforge.net/")) and SSH access on the remote.

If you do not already have SSHFS installed, then search your distribution’s repositories, using your favourite package manager.

To use this, simply type:

    sshfs (user)@(system):(remote mountpoint) (local mountpoint)

For example, we have a VPS, and would like to mount the contents of __/var/www/html__ to a folder in __~/Projects__. As with mounting in folders, it must be empty and created before the procedure.

Assuming it doesn’t already exist, we will call the folder ‘VPS’:

    mkdir ~/Projects/VPS
    
That should result in the creation of the required folder, then:

    sshfs root@randomdns.com:/var/www/html ~/Projects/VPS
    
That should prompt for pass, unless you use a passless key, or a key with a passphrase. The remote system should now be part of the local system.

##SFTP

Requirements: Your computer has programs that allows for SFTP. (Nautilus, default file manager of gnome, has this by default) All that is needed on the server-side is an SSH daemon running.

In Nautilus, go to _File / Connect to Server..._. Now to connect to your remote machine running SSH, you need to change the _Type:_ to _SSH_ and enter in the correct information. If information and connection to server is possible, Nautilus will open the directory on the remote system.

##FTP

Requirements: Your computer should already have a FTP client, if not install one through your systems package manager. And the host should be running an FTP server.

It is worthy to note that FTP is _not_ encrypted. This allows for the risk of your data to be eavesdropped, thus possibly compromising your system and or the data.

With that said FTP is used more commonly and is a bit faster due to less overhead then encrypted transfers. Most common application for FTP is its anonymous public access.

If you only need users that already blong to the system to get access to file on the machine, SFTP and SSHFS are better solutions.


