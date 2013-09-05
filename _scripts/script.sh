#!/bin/bash
jekyll build || exit 1
mv ./_binaries/* ./_site
