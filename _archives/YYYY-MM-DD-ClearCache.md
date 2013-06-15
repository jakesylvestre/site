---
layout: post
status: draft

title: Clear cache
category: tiny-commands
tags: [sysctl, ram, cache, "tiny command"]
author: [wei2912]

sources: http://duopetalflower.blogspot.sg/2009/09/clearing-cache-memory-in-linux-using.html

summary: Learn how to clear the cache quickly!
---
In Linux, when we copy files with large sizes, the content gets cached in RAM for faster access even though we might not need it later. To save RAM, we can forcefully clear the RAM cache using:

    sudo sync && sudo sysctl -w vm.drop_caches=3 && sudo sysctl -w vm.drop_caches=0

The above line is a combination of three commands

1. sync - to ensure any pending cache is flushed onto disk

2. sysctl -w vm.drop_caches = 3 - to clear all caches (pagecache and inode/dentry caches)

3. sysctl -w vm.drop_caches = 0 - reset the drop_caches to no clearing

The above command clears the whole cache in RAM. Take note, this clearing cache works in Ubuntu according to my tests but in other distributions it may not work.
