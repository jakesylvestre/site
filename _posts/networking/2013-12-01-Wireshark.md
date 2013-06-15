---
layout: post
title: Wireshark
category: networking
tags: [networking, wireshark]
author: [EyeR, wei2912]
summary: Wireshark is a packet capture utility and network protocol analyzer – It lets you look deep into how networks work, thus you can see what the computer sees.
status: draft

location: _posts/networking/2013-12-01-Wireshark.md
img: /img/networking/Wireshark/cover.png
---

As Wireshark samples, you can interact with it real time – or save it for later reference. It has many wonderful features, like colourising the packet-flow. Different types of traffic will have different colours which allows you to easily pick up things from the masses of data that are transmitted. It can actively filter and track data streams, You can get more detailed information from the [Wireshark FAQ](http://www.wireshark.org/faq.html) or [Sniffing FAQ](http://newdata.box.sk/2001/jan/sniffing-faq.htm). If you’d like to learn more on how networks work, [Protocols.com](http://www.protocols.com/protocols.htm) is an excellent resource – as are all the [RFC manuals](http://www.rfc-editor.org/).

It'll be best to search the repositories for your distribution.

    yum install wireshark
    
OR

    aptitude install wireshark

Follow the standard procedure of installation. If you do not find Wireshark for your distribution, then you may be able to locate here under [Third Party Packages](https://www.wireshark.org/download.html#thirdparty).

<!--more-->

It requires root permissions to function, so go ahead and make yourself a root user, or add “sudo”.

As a Wireshark user, you can also get a free [ebook](http://www.riverbed.com/us/media/documents/deployment_guides/network_monitoring_and_troubleshooting_for_dummies.php) from Riverbed, although it requires you to fill up a form. It is part of the ‘For Dummies’ series of books, “Network Monitoring and Troubleshooting for Dummies”. It should provide valuable reference for both the novice and experienced computer user alike.

##After installation

Once wireshark is installed and loaded, you’ll need tell it what to do.

In the toolbar, you should find a little icon, picture of a network card and a spanner – Config Capture.

If clicked, will yield a form where you can alter many settings. Most of them are obvious, like filename. When running long captures, it may be best to work with multiple files or set a new file before the load of the capture impedes upon your system.

You’d ideally need to set the cache for at least double the size of the capture file. This will give you a whole files room, whilst you process and save the previous. Heavier loads and larger capture files (I personally use 30-50MB files, on a 64-120MB cache – Tweak to suit your system, and network load) may require a larger cache.

You’ll also need to select a capture interface, from the drop-down list. If you connect wirelessly, select your wireless card. If you connect via USB Mobile broadband modem, select ppp0 (or anything else relevant).

Start the capture and watch your traffic magically appear on your screen.

What can you do with that information? Loads of stuff. Two of them are fault-finding diagnostics, and evidence gathering. Enjoy wireshark!
