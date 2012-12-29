#!/bin/bash

git pull origin master
jekyll --no-server
git add * .nojekyll
git commit -m "Regenerate website"
