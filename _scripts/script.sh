#!/bin/bash
jekyll build
mv ./_binaries/* ./_site
ls -aR ./_site/*
