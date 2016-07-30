#!/usr/bin/env bash
# Does some magic to get lulu resources on GHP.
# http://hacsoc.org/lulu

ORG=hacsoc
REPO=lulu
EMAIL=hacsoc-officers@case.edu
set -e
# GH_TOKEN is set in .travis.yml
# -> https://gist.github.com/brenns10/f48e1021e8befd2221a2

# Clone the gh-pages branch outside of the repo.
git clone -b gh-pages "https://$GH_TOKEN@github.com/$ORG/$REPO.git" ../gh-pages

### STEP 1: GENERATE COMMAND LISTING

# Comment out the hubot-redis-brain plugin.  Its output is unpredictable and
# annoying.
mv external-scripts.json external-scripts.json.bak
grep -v hubot-redis-brain external-scripts.json.bak \
     > external-scripts.json

# Capture lulu's help output with a helper script.
./lulutest "help .*" |\
    # Delete the first and last line
    head -n -1 | tail -n +2 |\
    # Delete the color codes
    sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" |\
    # Do the right line endings.
    tr -d '\r' > ../gh-pages/_includes/commands.txt

# Restore the old version of external-scripts.json
mv external-scripts.json.bak external-scripts.json

### STEP 2: GENERATE ENVIRONMENT VARIABLE LISTING
grep -Eor 'process.env.\w+' |\
    cut -d: -f2 | cut -d. -f3 |\
    tr '[:lower:]' '[:upper:]' |\
    sort -u > ../gh-pages/_includes/env.txt

### STEP 3: COMMIT AND PUSH GH-PAGES
cd ../gh-pages
# Update git configuration so I can push.
if [ "$1" != "dry" ]; then
    # Update git config.
    git config user.name "Travis Builder"
    git config user.email "$EMAIL"
fi

# Add and commit changes.
git add -A .
if [ "$1" != "dry" ]; then
    # -q is very important, otherwise you leak your GH_TOKEN
    git commit -m "[ci skip] Autodoc commit for $COMMIT."
    git push -q origin gh-pages
fi
