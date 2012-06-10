#!/bin/bash

jekyll --no-server
git checkout gh-pages
git pull origin gh-pages
rsync -vur --delete _site/* .
rm -rf _site
git add *
git commit -m "Regenerate website"
