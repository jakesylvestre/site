---
author: EyeR
summary: EyeR throw in a summary here :)
category: networking

location: _posts/networking/YYYY-MM-DD-Iptables.md
---

To start, what is iptables?
 
From the manpages:
 
> Iptables is used to set up, maintain, and inspect the tables of IPv4 packet filter rules in the Linux kernel.  Several different tables may be defined. Each table contains number of built-in chains and may also contain user-defined chains.
 
iptables is a kernel-level firewall, essentially this means the firewalling is done at a 'kernel level' - The most core component of an OS. By executing the firewall filtering at this level you can process packets before anything else. It works by the construction of 'chains' - a set of rules that can be applied to packets, With what it does to them called targets.
 
An example of this would be:
 
	Chain INPUT (policy ACCEPT)
	target     prot opt source               destination
	fail2ban-SSH  tcp  --  anywhere             anywhere            tcp dpt:ssh
	ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED
	ACCEPT     icmp --  anywhere             anywhere
	ACCEPT     all  --  anywhere             anywhere
	ACCEPT     tcp  --  anywhere             anywhere            state NEW tcp dpt:ssh
	REJECT     all  --  anywhere             anywhere            reject-with icmp-host-prohibited
 
	Chain FORWARD (policy ACCEPT)
	target     prot opt source               destination
	REJECT     all  --  anywhere             anywhere            reject-with icmp-host-prohibited
 
	Chain OUTPUT (policy ACCEPT)
	target     prot opt source               destination
 
	Chain fail2ban-SSH (1 references)
	target     prot opt source               destination
	RETURN     all  --  anywhere             anywhere
 
As you can see, it builds 'tables' from chains, populated by rules.  The chains INPUT, OUTPUT and FORWARD should be self explainitory, and fail2ban has made itself a chain for dealing with SSH auth failures. The rules to these chains easily manipulated.
 
For example, there is a deviant attempting to brute your system, You can simply define a new rule(depending on your user privileges, may require sudo):
 
	iptables -A INPUT -s 85.17.245.118 -j DROP
 
the '-A' switch tells iptables your intention is to add a rule, another common option is '-D' - remove a rule - clearly, INPUT is the chain you're adding this rule to - Inbound traffic - and output would be outbound traffic. the '-s' switch is source, So all packets 'from' -=- and the '-j' is for 'jump' indicates target it will jump to, in this case drop
 
There are alternates to drop, but to keep this simple, we'll stick to DROP and ACCEPT - allow and deny - the major difference between denying a connection and droping it, is that when dropped there is no response - in fact, it never actually gets processed. It just gets 'dropped' - Like it's hot.
 
Should you ping a system with those ports 'closed', it will return a 'destination unreachable' message. Via DROP however, it doesn't bother, and thusly the remote system cannot be sure there is even a system in receipt(which it isn't) of its packets.
 
You can also do more than filter by IP, Say you wished to allow the above attacker to continue to use other services, yet continue to isolate from your SSH server, then the '--dport' flag will enable you to specify a port:
 
	iptables -A INPUT -s 85.17.245.118 --dport 22 -j DROP
 
Would *only* ignore packets from that IP on port 22 - other useful switches are '-d' destination IP, '-p' protocol ie: tcp  / udp  / icmp, and '-i' allows you to specify interface. Combinations of these will allow you to fabricate rules to cover most senarios.
 
'Security Hardening' can be slightly achieved by changing the iptables default policy to 'DROP' - Anything it isn't explicitly expecting is dropped. Although for a lot of users, esp those hosting a service, this is unsuitable. For extra paranoia, do the same to the 'OUTPUT' chain.

Now, to find something practical to do with this... Well, If you're 'paranoid'(like me) then you may not appreciate things like various projects in place by people like Akamai Technologies.  To cut a long rant short they use the excuse of operating a CDN (Content Delivery Network, the idea is to cache data closer to the point of delivery, for speed in access. The reality is they skim your data) This is achieved by operating a "huge network spider spread across more than 70 countries." (See the list of IP's below).

They use this to actively sniff traffic, amongst other things. For more refernce, vist http://www.matveev.se/net/akamai.htm - But my list below gets more machines. I won't pretend its near complete, but covers thousands of machines.
 
Using the commands:
 
    iptables -A INPUT -s 2.16.0.0/13 -j DROP
    iptables -A INPUT -s 2.18.16.0/20 -j DROP
    iptables -A INPUT -s 2.18.32.0/20 -j DROP
    iptables -A INPUT -s 2.20.192.0/20 -j DROP
    iptables -A INPUT -s 2.23.144.0/20 -j DROP
    iptables -A INPUT -s 2.22.48.0/24 -j DROP
    iptables -A INPUT -s 23.0.0.0/12 -j DROP
    iptables -A INPUT -s 23.32.0.0/11 -j DROP
    iptables -A INPUT -s 23.64.0.0/14 -j DROP
    iptables -A INPUT -s 60.254.128.0/18 -j DROP
    iptables -A INPUT -s 62.115.0.0/16 -j DROP
    iptables -A INPUT -s 69.192.0.0/16 -j DROP
    iptables -A INPUT -s 72.246.0.0/15 -j DROP
    iptables -A INPUT -s 74.125.0.0/16 -j DROP
    iptables -A OUTPUT -s 74.125.0.0/16 -j DROP
    iptables -A INPUT -s 80.239.128.0/19 -j DROP
    iptables -A INPUT -s 80.239.160.0/19 -j DROP
    iptables -A INPUT -s 80.239.192.0/19 -j DROP
    iptables -A INPUT -s 80.239.224.0/19 -j DROP
    iptables -A INPUT -s 84.53.168.0/22 -j DROP
    iptables -A INPUT -s 88.221.94.0/23  -j DROP
    iptables -A INPUT -s 88.221.176.0/21 -j DROP
    iptables -A INPUT -s 92.122.50.0/24 -j DROP
    iptables -A INPUT -s 92.123.64.0/22 -j DROP
    iptables -A INPUT -s 95.100.0.0/15 -j DROP
    iptables -A INPUT -s 95.100.96.0/23 -j DROP
    iptables -A INPUT -s 95.101.152.0/22 -j DROP
    iptables -A INPUT -s 96.6.0.0/15 -j DROP
    iptables -A INPUT -s 96.16.0.0/15 -j DROP
    iptables -A INPUT -s 125.252.192.0/18 -j DROP
    iptables -A INPUT -s 173.222.0.0/15 -j DROP
    iptables -A INPUT -s 173.194.0.0/16 -j DROP
    iptables -A OUTPUT -s 173.194.0.0/16 -j DROP
    iptables -A INPUT -s 184.24.0.0/13 -j DROP
    iptables -A INPUT -s 184.84.0.0/14 -j DROP
    iptables -A INPUT -s 209.85.128.0/17 -j DROP
    iptables -A OUTPUT -s 209.85.128.0/17 -j DROP
    iptables -A INPUT -s 217.208.0.0/13 -j DROP
 
We can then prevent being served content from Akamai, instead of the provider we'd expect. Don't worry, it won't harm your ability to browse the sites you choose. Once 'the network' figures out you won't talk to Akamai, it will go and fetch the content from where it should do.
