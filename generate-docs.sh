#!/usr/bin/env sh

# This script will automatically save Hubot's help command output to a file, and
# then stick it into the appropriate place in the gh-pages branch.  Finally, it
# will leave the gh-pages branch ready to commit (but it won't commit, cause
# that would be rude).  You need to have:
# - expect: a program that interacts with CLIs
# - GNU coreutils - tac, sed: I'm pretty sure I use some non-standard features.
#   Probably won't work if you're using a Mac!  Get Linux!
# Run the command with a clean directory.  If it removes some normal
# documentation, you may need to adjust the sleep time in lulutest.

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
fi > /dev/null

# Comment out the hubot-redis-brain plugin.  Its output is unpredictable and
# annoying.
mv external-scripts.json external-scripts.json.bak
grep -v hubot-redis-brain external-scripts.json.bak \
     > external-scripts.json

# Capture lulu's help output with a helper script.
./lulutest "help .*" |\
    # Delete the first line (the help command echoed)
    sed -e 1d | tac | sed -e 1d | tac |\
    # Delete the color codes
    sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" |\
    # Do the right line endings.
    tr -d '\r' > output.txt

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
