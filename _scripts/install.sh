#!/bin/bash
git submodule update --init --recursive || exit 1
sudo apt-get install python-pygments || exit 1
