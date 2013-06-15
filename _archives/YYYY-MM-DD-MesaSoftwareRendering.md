---
layout: post
title: Running Modern Desktop Environments With A Non-Modern GPU
category: desktop-environments
tags: [desktop environment, graphics, mesa, software rendering]
author: [wei2912]

status: post

original: http://forums.linuxmint.com/viewtopic.php?f=60&t=104132&start=0
---

As you’ve probably already experienced, it is extremely frustrating when you want to try out a new desktop environment, let’s say, Cinnamon, and find out that your graphics card is too old (maybe it doesn’t support 3D acceleration?). In that case, now there’s a way to overcome this! All you need to do is to enable software rendering. Software rendering is the usage of your CPU to render graphics instead of your GPU. CPUs are very versatile and will be able to support modern technology even if it is old.

Last time, this used to be the case – MESA didn’t work that well with software rendering. However, now it is much less glitchy! Here’s the magic command:

    export LIBGL_ALWAYS_SOFTWARE=1 cinnamon –replace

Run that in the terminal and watch Cinnamon start up!

(To adapt that to other desktop environments, replace cinnamon with something else)

The only issue is that your CPU will handle many more tasks, thus CPU usage will increase, but if you have a good CPU, that is a good compromise. Enjoy!
