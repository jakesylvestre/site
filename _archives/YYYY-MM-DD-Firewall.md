---
layout: post
title: How does a firewall work?
category: security
tags: [firewall, security]
author: [wei2912]

status: draft

sources: ["http://www.makeuseof.com/tag/firewall-work-makeuseof-explains/", "http://en.wikipedia.org/wiki/Firewall_%28computing%29"]

summary: The firewall was invented as a way of describing any software or hardware that protects a system/network from the web. As a result, security-savvy people and organizations look for ways to protect against such malware. Learn about the workings of this device that function on almost every GNU/Linux computer!
---

# Generations of firewalls

## Packet Filters

Packet filters act by inspecting the "packets" that transfer between computers on the net. If a packet matches the packet filter's set of rules, the packet filter can drop (silently discard without notice) the packet, or reject it (discard it and send an error back). Action might then be taken based off the information obtained. This is often efficient and fast, but may be vulnerable in some ways. Spoofing attacks, for instance, can be very effective against this.

## "Stateful" filters

Advanced versions of packet filter firewalls keep data about packets in memory till enough are obtained to "guess" its state. They can change their behavior based on network events. However, certain denial-of-service attacks can bombard the firewall with thousands of fake connection packets and fill its connection state memory, thus causing it to be overwhelmed.

## Circuit Gateways

Circuit gateways tries to make sure that a connection relaying packets is valid as well as make use of packet header data. To do this, a circuit gateway checks packet data and looks for changes, like an unusual source IP address or destination port. If a connection is determined as invalid, it may be closed. These firewalls can also automatically reject information not specifically requested by a user behind the firewall.

## Application Level Gateways

These firewalls are similar to circuit gateways, but they check the information being sent through the firewall and observe how it relates to specific applications and services. For example, an application level gateway can check packets carrying web traffic and obtain information about what sites the packets are from. The firewall can then block data from certain sites.

# Firewalls in Linux

## iptables
coming soon...
