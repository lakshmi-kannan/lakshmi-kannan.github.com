#!/bin/bash

git pull origin master
cd _source
jekyll build
cd ..
rsync -vur --delete _source/_site/* .
rm -rf _source/_site
git add . .nojekyll
git commit -m "Regenerate website"
