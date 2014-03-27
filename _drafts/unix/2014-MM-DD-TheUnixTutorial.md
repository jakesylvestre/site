---
layout: post

title: The Unix Tutorial
category: unix
author: 
  - dams
  - wei2912

summary: So, you've heard about Linux and a buncha other OS'. You may come from a Windows environment, or maybe you're just a Linux user who's now interested in learning more about the system. In that case, you're in the right place. I'll try to express a few of the points that a new user encounters when he enters the *nix world.
---

# CHAPTER 1: UNIX minus history
 
Let me begin by explaining as to what the term "Unix" actually means. Unix is this operating system that was designed by a certain company by the name AT&T many years back.
Unfortunately, the "code"(a.k.a Source) for the Unix OS was, what we call "closed source", in the sense that people outside the company weren't able to view it or make changes to it. It was Proprietary.
 
Here's where your GNU/Linux (and a few other UNIX-like OS') comes in. GNU/Linux ISN'T UNIX. It's basically another OS that tries to inculcate the properties associated with UNIX (the UNIX philosophy).
Even though the code wasn't available, the properties of the UNIX OS could be inferred from usage and other sources.
 
Instead of using just ideas from UNIX OS like GNU/Linux, there's other OS' that try to imitate UNIX OS as closely as possible. One of the popular one's is FreeBSD, which is a derivative of UNIX.
 
In short: UNIX (daddy) + (other mothers) -> FreeBSD (Almost the same DNA)
While Linux is more like a fella who wants to look/behave like UNIX OS (More beauty creams than DNA similarities).
 
GNU/Linux, FreeBSD and a multitude of other OS' fall under a category called "Open Source", wherein volunteers and the general public can freely view the code(source) for the Operating system and make changes. There is a streamlined procedure to prevent messups.
 
I'm now tired of typing GNU before every Linux word. Henceforth it shall be assumed that I shall be referring to GNU/Linux whence I say "Linux", unless the context infers otherwise.
Before you think I was adding an extra 3 letters to add bulk to the text, let me go forward and explain the case:
"Linux" is basically a kernel. Suffice to say that the kernel is the "software CPU" of the OS. So, it's pretty useless unless it has applications on which it can do its processing magic on.
A majority of these applications (as of this writing) are provided by another entity by the name... "GNU". And hence to pay due credit to this Open-Source Institution, we say "GNU/Linux". I will not thread anymore on this topic as I've lost a few fingers in the last flame war.
 
UNIX and UNIX-like OS's are sometimes also referred to as "*nix". The "*" is a special symbol that acts as a placeholder (for 'n' number of letters) in a variety of *nix programs; In the most simplest of cases, it may represent the 'U' or a 'u'... You will encounter more of such symbols on your journey.
 
Give yourself a pat on the back, or if that's too straining just imagine it... For you my Lord, have completed Chapter 1!
 
# CHAPTER 2: The Operating System
 
I'll try to be as gentle as possible.
The operating system, the UNIX style, is made up of several bits of functional units, that interact with each other to give you a unique and relatively comfortable experience when using the Computer.
 
I'll try to chop these down into layers:
 
Layer Zero: Your Hardware (not really the OS, but Shhh....): It includes your monitor, CPU, RAM, mouse(and other peripherals), etc, etc.
 
And now, begins the OS:
Layer One: The kernel: This is the conductor, the maestro of the OS Orchestra. The kernel handles information processing. It allocates memory to programs, decides which process gets priority on the CPU, talks and coordinates information between the various hardware, routing data to/from them to the requisite place.
Windows XP called it's kernel "NT", GNU/Linux has the Linux kernel, FreeBSD has the BSD kernel, Mac OS X uses the Mach kernel.
 
Layer Two: Depending on a lot of factors, this layer can be split into a few more and made complicated. To keep it simple, this layer handles information between the kernel and the user applications. It could contain something from device drivers to software that handles file and memory management.
In some instances, it may even mimic another layer of fake software-based "hardware", as in virtualization which allows one to run multiple OS' INSIDE the base OS.
 
Layer Three: User Applications. This includes the "shell" that you've heard so much about. It's just another application, just like that graphical calender.
 
Layer Four: Your brain? Eyes and fingers, maybe?
 
Let us draw stuff to explain that now:
Calculator application -> *magic* (helper programs to draw the window... libraries, etc.) -> kernel (chews the data to make it palatable to the CPU) -> CPU -> Kernel (chews it again to feed to the application) -> Calculator app.
In perspective: 1 + 1 -> *magic* displays it on screen -> kernel "chews" it -> CPU: 1+1=2 -> kernel -> 3 (displayed after more magic... graphics, fonts, etc...)
 
Why does the kernel have to "chew" the data?
That's not all the kernel does. It will handle where the data will be stored in memory, and HOW the CPU will handle it.
Now CPU's come in all shapes and sizes and they all have different "languages". It would have been difficult for an application developer to write code for all these "languages".
So applications "talk" to the kernel (in the language it understands), which then trnaslates this to the CPU's/hardware's language.
The kernel, being the coordinator, can also handle security issues, housecleaning, hardware protection, etc.
 
A few operating systems: Ubuntu, other GNU/Linux OS', FreeBSD, OpenBSD, NetBSD.
 
# CHAPTER 3: The Shell