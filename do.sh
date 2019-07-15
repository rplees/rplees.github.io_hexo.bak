#!/bin/sh

#_now = $(date "+%Y%m%d-%H%M%S")

hexo clean
hexo generate
cp -R public/* .deploy/rplees.github.io
cd .deploy/rplees.github.io
git add .
git commit -m "update ${date}"
git push origin master
