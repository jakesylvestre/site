---
layout: post
status: draft

title: Shutting Down Linux
category: commands
tags: 
  - shutdown
  - reboot
  - poweroff
  - sysrq
  - commands
author: 
  - programmerdams
  - wei2912
  - diabolist

summary: Shutting down Linux isn't as simple as pushing a switch. Learn how to shutdown Linux properly.

location: _posts/generic-linux/2013-01-06-ShutdownLinux.md
---

There's halt, shutdown, reboot, poweroff. So which one should you use?

The "shutdown" command should suit most of your needs.

Here's how to use it:

## To bring the system down and so with a complete poweroff

{% highlight bash %}
shutdown -hP now
{% endhighlight %}

If you're inquisitive, you may like to ask why I've added the -P. it seems redundant when the -h will power the system down for you, right?
Well.. The -h gives the system the option to just "halt" or do a complete poweroff. So, on some systems, the machine may NOT poweroff completely.

So, how do I do a reboot?

{% highlight bash %}
shutdown -hr now
{% endhighlight %}

Please note: You need the "now" in the command in order to shutdown immediately. Read the man page for more info.

<!--more-->

## Why Can't I just use halt? It does the same thing, doesn't it?

Shooting a sedated person in the heart is much better than shooting him when he's fully conscious.

The shutdown command is gentler in exiting processes.

## Oh wait. I need something done, but I've run the shutdown command! HELP!!

Don't panic.

A) "shutdown -c"

B) Get the pid of the shutdown command using "ps | grep shutdown". Kill the process using "kill pid"

C) "killall shutdown"

NOTE: This works best if you've set a decent time interval before the shutdown. If you set it to "now", don't bother.

## So, what exactly happens during the shutdown?

I won't bore the reader with technicalities, but here are a few things that happen:

- The discs are synced (data buffered in the RAM is written to disc) - This prevents data loss (in case for a forced shutdown)
- The runlevels are changed appropriately, 0 and 6. 0 is for Halt (shutdown), 6 is for Reboot.
- The processes are allowed to exit themselves.

Let's just say that a proper shutdown will improve your systems reliability and prevent unnecessary loss of data (these include your son's 1st birthday photos).

## Uh, my computer isn't responsive. Can I safely poweroff my computer?

Yes. There is a method in-which is more hands-on but will ensure that your data is safe...

***Note that this is not safer than using the "shutdown" command. It is more risky than using the "shutdown" command and is generally not advised to be used unless in conditions such as the above.***

Have you ever seen that 'Sys Rq' button on your keyboard (it might be the Print Screen button)? In the Linux kernel, in combination with Alt, it is used to allow the user to perform low-level tasks no matter what state the system is in. It is mostly used to bring a system down without corrupting the filesystem. Heres how we do it.

Remember this:

- Raising
- Elephants
- Is
- So
- Utterly
- bOring(shutdown) or Boring(reboot)

Huh?

Ok. The first think we want to do is to take back control from Xorg.

{% highlight bash %}
Alt + SysRq + R
{% endhighlight %}

You wont notice any changes, but wait a second before hitting the next combination of keys to ensure it executed. Now, we want to stop all running tasks... This will send SIGTERM or Terminate to *all* processes currently running.

{% highlight bash %}
Alt + SysRq + E
{% endhighlight %}

Wait about 5-10 seconds. Now we make sure there are no left over processes by sending SIGKILL or simply Kill _all_ remaining processes.

{% highlight bash %}
Alt + SysRq + I
{% endhighlight %}

Now it is time to Sync our disks to prevent data loss.

{% highlight bash %}
Alt + SysRq + S
{% endhighlight %}

It is now time to prepare our File systems for the reboot by mounting them all to Read-only.

{% highlight bash %}
Alt + SysRq + U
{% endhighlight %}

And finally! Time to shutdown, or reboot.

{% highlight bash %}
(shutdown)Alt + SysRq + O  (reboot)Alt + SysRq + B
{% endhighlight %}

Now, you can press that power on button with confidence and coming back to a error-less boot :-)

For more about the Magic SysRq Key and combinations to be used with it, [check them out here](http://en.wikipedia.org/wiki/Magic_SysRq_key).

### How on earth do i do the above properly?!

Hold down Alt + SysRq on the keyboard and use your other fingers to press these in sequence: "R E I S U O/B".
