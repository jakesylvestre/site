#!/bin/bash
DIR="/home/wei2912/GitHub/nixtuts/site"
rsync -r -a -z $DIR/mysite_files/* universe2:~/mysite_files/
