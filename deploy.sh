#!/bin/bash

echo "\033[0;32mDeploying updates to GitHub ... \033[0m"

# Build the project in hugo
hugo

# Add changes to git
git add -A

# Commit changes
msg="Rebuilding site `date`"
if [ $# -eq 1 ]; then
    msg="$1"
fi
git commit -m "$msg"

# Push source and build repo
git push origin master
git subtree push --prefix=public git@github.com:rustybear/hugo_site.git gh-pages

echo "\033[0;32mFinished updates to GitHub. Enjoy!  \033[0m"

