---
layout: post

title: Cowsay Fortunes
category: games
author: 
  - wei2912

summary: Many geeks are bored with staring at a blank terminal screen, trying to remember the commands they need to use. Here's a nice little way to add some fun to your terminal life.
---

*The original tutorial was published at [https://sites.google.com/site/debininja/tutorials/fun-fortunes](https://sites.google.com/site/debininja/tutorials/fun-fortunes). We've been given permission to replicate the tutorial and add onto our own edits*

## Basics
So, what's fortune? And what's cowsay?

Fortune is a commandline program which'll display random quotes, funny sayings, or attempt to "predict" (with a psuedorandom generator) your future.

![fortune](/img/games/CowsayFortunes/fortunes.png "A peek at what fortunes look like...")

Cowsay is a commandline program that displays text inputted into a talking cow. Cowthink will do the same for a thinking cow.

![cowsay](/img/games/CowsayFortunes/cowsay.png "Bored cows.")

Before you start, you must make sure that you have installed the necessary packages. You can either give them a compile or install your distribution's version.

<!--more-->

## Removing your unwanted cows and fortunes...

Be noted that some fortunes and cows are offensive. You should remove them before-hand.

{% highlight bash %}
$ ls /usr/share/cowsay/cows/
{% endhighlight %}

See anything disturbing? Remove it!

As for fortunes... make sure not to install offensive fortunes.

## Enabling fortunes

### If you're using Linux Mint...

Linux Mint has a fortune script, similar to the one we're using in this tutorial (in fact, we took it from there).

They're disabled in Mint 12 or 13 by default. But it's pretty easy to get them back!

Then, run this in the terminal:

{% highlight bash %}
$ gconftool-2 --type boolean --set /desktop/linuxmint/terminal/show_fortunes true
{% endhighlight %}

If that doesn't work, try using mate's config tool:

{% highlight bash %}
$ mateconftool-2 --type boolean --set /desktop/linuxmint/terminal/show_fortunes true
{% endhighlight %}

## And if you aren't...

### Automatic fortunes + cowsay

This option will automatically display a fortune ALONG with a random cowsay creature whenever you open a terminal. Add this to  ~/.bashrc (or the global bashrc file):

{% highlight bash %}
$ cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) $(fortune)
{% endhighlight %}

Reopen the terminal. You should see your fortunes!

Now, here is the explanation. The "cowsay -f" option allows a person to choose a creature to say the thought (in this case I made it random).

The "ls /usr/share/cowsay/cows/" lists all the .cow files (which contain the creatures) and the list is handed over to "shuf" which obviously shuffles or randomizes them.

The "fortune" bit is the actual fortune that is outputted via the random animal; the "tee -a" takes the output of what "echo" echoed (which is our command) and adds it at the end of a file (over here, that is .bashrc).

### Automatic fortunes + cowsay, with your own chosen cows

Copy and paste this into ~/.bashrc (or the global bashrc file). Do not wipe out the whole file.

{% highlight bash %}
# fortunes!
function show_fortune {
	RANGE=3
	number=$RANDOM
	let "number %= $RANGE"
	case $number in
		0) cow="moose"; ;;
		1) cow="tux"; ;;
		2) cow="koala"; ;;
	esac
	
	RANGE=2
	number=$RANDOM
	let "number %= $RANGE"
	case $number in
		0) command="/usr/games/cowsay"; ;;
		1) command="/usr/games/cowthink"; ;;
	esac
	
	/usr/games/fortune | $command -f $cow
}

show_fortune
{% endhighlight %}

The script generates a random cow, either mooose, tux or koala. Then, it generates a random command, either cowsay or cowthink. Finally, it runs the fortune command and pipes it to the cow command.

#### Adding more "cows" (or animals) to the script

There are many cows avaliable. Here are some of them:
- small
- tux
- koala
- moose

There are a lot more "cows" that you can use, though. Run this command to see all of them:

{% highlight bash %}
$ cowsay -l
{% endhighlight %}

And to list the files in /usr/share/cowsay/cows:

{% highlight bash %}
$ ls /usr/share/cowsay/cows
{% endhighlight %}

Let's edit the bashrc file. Here's the section which generates the cows.

{% highlight bash %}
RANGE=3
number=$RANDOM
let "number %= $RANGE"
case $number in
    0) cow="moose" ;;
    1) cow="tux" ;;
    2) cow="koala" ;;
esac
{% endhighlight %}

Lets say you want to add the cow, "dragon", to it. Add a new entry under the last one and increase the value of RANGE by 1:

{% highlight bash %}
RANGE=4
number=$RANDOM
let "number %= $RANGE"
case $number in
    0) cow="moose" ;;
    1) cow="tux" ;;
    2) cow="koala" ;;
    3) cow="dragon" ;;
esac
{% endhighlight %}
  
### Automatic fortunes ONLY

Paste this line into ~/.bashrc

{% highlight bash %}
$ fortune
{% endhighlight %}

### On-demand fortunes + cowsay

This is a good idea if you're not bored all the time, but when you are bored, you can call the cows and other creatures on demand to entertain you.

Paste the following line into ~/.bashrc or the global bashrc file. (Note: for the alias, the command should NOT be "fortune" as it is already used).

{% highlight bash %}
$ alias fortunes='cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) $(fortune)'
{% endhighlight %}

The "alias" acts like a placeholder so when you issue your custom command, it will execute whatever you set that alias to.

Now whenever you want to call on the animals and fortunes, type in "fortunes" in the terminal and press enter! That's it!

Wikipedia can explain more: [http://en.wikipedia.org/wiki/Alias_(command)](http://en.wikipedia.org/wiki/Alias_(command))

## Adding your own cows

Now, to add your own cows - grab a picture. Any picture will do. And now put it through the magic of ASCII art generators (http://www.glassgiant.com/ascii) to get some ASCII art. You could create yours manually too.

For example, I have a ASCII version of the ledgenary floppy disk:

{% highlight bash %}
.-----------------------------.          
|  .-----------------------.  |          
|  |                       |  |          
|  |                       |  |                 
|  |                       |  |          
|  `-----------------------'  |          
|      _________________ __   |          
|    |   ___         |     |  |          
|    |  |   |        |     |  |                
|    |  |___|        |     |  |          
|____|_______________|_____|__|
{% endhighlight %}

Now that you have one, it's time to make your cow file.

Go to __/usr/share/cowsay/cows__ and create a new file, titled "namehere.cow". In this example I'll use "floppy-disk.cow". Make sure your name does not have spaces. You will need sudo access for this.

Then, start off your file with:

{% highlight bash %}
$the_cow = <<"EOC";
{% endhighlight %}

Paste the contents of the ASCII art into the rest of the file. To choose where for the thoughts to be displayed, use $thoughts. Usually it's displayed as an indent of 2 spaces every line, 4 lines.

End off your file with EOC.

Here's an example:

{% highlight bash %}
## Floppy disk
## for geeks!
$the_cow = <<"EOC";
$thoughts
  $thoughts
    $thoughts
      $thoughts
.-----------------------------.          
|  .-----------------------.  |          
|  |                       |  |          
|  |                       |  |                 
|  |                       |  |          
|  `-----------------------'  |          
|      _________________ __   |          
|    |   ___         |     |  |          
|    |  |   |        |     |  |                
|    |  |___|        |     |  |          
|____|_______________|_____|__|
EOC
{% endhighlight %}

Now, test it out with a fortune!

{% highlight bash %}
$ cowsay -f floppy-disk $(fortune)
{% endhighlight %}

Check for any defects.

## Editing the fortunes you generate

We've had a lot of fun with cowsay - back to fortunes, the basis of all of this.

Let's take a look at the fortunes I have.

{% highlight bash %}
$ fortune -f
100.00% /usr/share/games/fortunes
     4.87% husse-moderating
    57.96% literature
     3.76% husse-funny
    30.53% husse-helping
     2.88% husse-self
{% endhighlight %}

Here you can see the composition of the fortunes I have.

Here's the complete list:

{% highlight bash %}
$ ls /usr/share/games/fortunes
{% endhighlight %}

Look at the files without extension ".dat". They are fortunes, seperated by %.

### Adding fortunes

You can grab some fortunes from [http://www.shlomifish.org/humour/fortunes/](http://www.shlomifish.org/humour/fortunes/). They should come with .dat extensions. Move them to /usr/share/games/fortunes

To create your own, start off with a couple of quotes. Name the file appropirately.'

For example, I created the file "stackoverflow", referring to the programming website. Here's some of what I put:

{% highlight bash %}
## Don't close questions where the user has requested that it not be closed [closed] ##
The system should search posts for the word "please" in proximity to the phrase "don't close" or "do not close", and if found together disable the close link for the following reasons:
	
* They asked nicely
* They knew enough about the system to understand that posts can be closed, and thus are experienced enough to know when their own question is perfectly valid and reasonable
	
Please consider this question an opportunity to consider the issue carefully. I'll convert it to a feature request when abs(votes) > 100, until then it'll merely be a discussion.

-- Adam Davis
-- http://meta.stackoverflow.com/questions/99062/dont-close-questions-where-the-user-has-requested-that-it-not-be-closed
%
Q: What's the difference between JavaScript and Java?
	
-- Guy
-- http://stackoverflow.com/questions/245062/whats-the-difference-between-javascript-and-java
	
A: Java and Javascript are similar like Car and Carpet are similar.
	
-- Greg Hewgill
-- http://stackoverflow.com/questions/245062/whats-the-difference-between-javascript-and-java#245068
%
Q: What is the best comment in source code you have ever encountered? By Tim Post at http://stackoverflow.com/questions/184618/what-is-the-best-comment-in-source-code-you-have-ever-encountered/482129
	
I am particularly guilty of this, embedding non-constructive comments, code poetry and little jokes into most of my projects (although I usually have enough sense to remove anything directly offensive before releasing the code). Here's one I'm particulary fond of, placed far, far down a poorly-designed 'God Object':
	
	/**
	* For the brave souls who get this far: You are the chosen ones,
	* the valiant knights of programming who toil away, without rest,
	* fixing our most awful code. To you, true saviors, kings of men,
	* I say this: never gonna give you up, never gonna let you down,
	* never gonna run around and desert you. Never gonna make you cry,
	* never gonna say goodbye. Never gonna tell a lie and hurt you.
	*/
	
	I'M SORRY!!!! I just couldn't help myself.....!
	
And another, which I'll admit I haven't actually released into the wild, even though I am very tempted to do so in one of my less intuitive classes:
	
	// 
	// Dear maintainer:
	// 
	// Once you are done trying to 'optimize' this routine,
	// and have realized what a terrible mistake that was,
	// please increment the following counter as a warning
	// to the next guy:
	// 
	// total_hours_wasted_here = 42
	// 
	
-- Jens Roland 
-- http://stackoverflow.com/questions/184618/what-is-the-best-comment-in-source-code-you-have-ever-encountered/482129#482129
%
{% endhighlight %}

By the way, the complete fortune is downloadable at [stackoverflow (a file)](/files/CowsayFortunes/stackoverflow) if you want to examine it.

Now, we're going to convert it into a .dat file.

{% highlight bash %}
$ strfile -c % stackoverflow stackoverflow.dat
"stackoverflow.dat" created
There were 24 strings
Longest string: 6020 bytes
Shortest string: 343 bytes
{% endhighlight %}

This gives you somewhat important data. At least, the second line "There were 24 strings". You now have 24 fortunes.

Copy the files over to our directory:

{% highlight bash %}
$ cp ./stackoverflow* /usr/share/games/fortunes/
{% endhighlight %}

The usage of the wildcard causes [stackoverflow](/files/CowsayFortunes/stackoverflow) (the list) and [stackoverflow.dat](/files/CowsayFortunes/stackoverflow.dat) (the data file) to be copied. Now, check if it was successful:

{% highlight bash %}
$ fortune -f
100.00% /usr/share/games/fortunes
	21.81% sharp-perl
	 3.43% husse-moderating
	 3.74% stackoverflow
	40.81% literature
	 4.05% sharp-programming
	 2.65% husse-funny
	21.50% husse-helping
	 2.02% husse-self
{% endhighlight %}

Now, 3.74% of our fortunes are from stackoverflow!
