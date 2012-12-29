#!/bin/bash

git pull origin master
jekyll --no-server
cd ..
rsync -vur --delete _source/_site/* .
rm -rf _source/_site
git add * .nojekyll
git commit -m "Regenerate website"
