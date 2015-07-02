#!/usr/bin/env sh

# This script will automatically save Hubot's help command output to a file, and
# then stick it into the appropriate place in the gh-pages branch.  Finally, it
# will leave the gh-pages branch ready to commit (but it won't commit, cause
# that would be rude).

# exit on error!
set -e

# Check if there are uncommitted changes.  We don't need to screw stuff up!
if [ "`git status --porcelain`" != "" ]; then
    echo "error: there are uncommitted changes"
    exit
fi

# Check if the gh-pages branch already exists.  If not, tell the user to get it.
if ! git branch | grep gh-pages; then
    echo "error: you don't have the gh-pages branch"
    echo "you should probably run \"git fetch origin gh-pages\""
    exit
fi

# Comment out the hubot-redis-brain plugin.  Its output is unpredictable and
# annoying.
sed -e '/hubot-redis-brain/s/^/\/\//' external-scripts.json -i.bak

# Capture lulu's help output with a helper script, and reformat it.
./lulutest "help .*" | sed -e 1d > output.txt

# Restore the old version of external-scripts.json
mv external-scripts.json.bak external-scripts.json

# Switch to the github pages branch and put the commands into place.
git checkout gh-pages
mv output.txt _includes/commands.txt
git add _includes/commands.txt

# Notify the user that they really ought to commit and push the changes.
echo "Successfully updated documentation."
echo "Don't forget:"
echo "  git commit -m \"documentation update\""
echo "  git push"
echo "  git checkout master"
