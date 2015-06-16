# lulu

This is an instance of GitHub's Campfire bot, hubot. It's pretty cool.

This instance is deployed on the [ACM IRC Server][acmirc] for our IRC uses.

[acmirc]: http://irc.case.edu

## Playing with Hubot

You'll need to install the necessary dependencies for hubot. All of
those dependencies are provided by [npm][npmjs].

[npmjs]: http://npmjs.org

## HTTP Listener

Hubot has a HTTP listener which listens on the port specified by the `PORT`
environment variable.

For the lulu implementation, it is recommended to run it with `--disable-httpd`
since irc.case.edu is a public-facing server.

##  Persistence

The `hubot-redis-brain` package is currently activated for lulu. This requires
an implementation of Redis in some way or another and the appropriate configuration. For further information, see [hubot-retis-brain doc](https://www.npmjs.com/package/hubot-redis-brain).

## Testing Hubot Locally

You can test your hubot by running the following.

    % bin/hubot

You'll see some start up output about where your scripts come from and a
prompt. Some status or error messages are expected if environment variables
are not fully configured.

Then you can interact with hubot by typing `hubot help`. This may have a very
long output due to the number of scripts installed.

## Adapter: IRC

Adapters are the interface to the service you want your hubot to run on. This
can be something like Campfire or IRC. There are a number of third party
adapters that the community have contributed. Check the
[hubot wiki][hubot-wiki] for the available ones.

As our IRC bot, lulu expects to be run with the IRC adapter as listed in
`package.json` under the dependencies. Part of lulu's run script should
include running it as:

    % bin/hubot -a irc [... other options]

[hubot-wiki]: https://github.com/github/hubot/wiki

## hubot-scripts

With the split legacy/current availability of scripts for hubot, lulu makes
use of both the current [external-scripts][external-scripts] and the legacy-
but-available [hubot-scripts][hubot-scripts]. Any bugs in these scripts should
be properly reported to the appropriate maintainer (if none exists, why not take
over? Easy, right? >.>).

To enable scripts from the hubot-scripts package, add the script name with
extension as a double quoted string to the `hubot-scripts.json` file in this
repo. Similarly, to add scripts from the hubot-scripts *project*, add the script
name with*out* extension as a double quoted string to the
`external-scripts.json` file in this repo.

[hubot-scripts]: https://github.com/github/hubot-scripts
[external-scripts]: https://github.com/hubot-scripts/

## external-scripts

Tired of waiting for your script to be merged into `hubot-scripts`? Want to
maintain the repository and package yourself? Then this added functionality
maybe for you!

Hubot is now able to load scripts from third-party `npm` packages! To enable
this functionality you can follow the following steps.

1. Add the packages as dependencies into your `package.json`
2. `npm install` to make sure those packages are installed

To enable third-party scripts that you've added you will need to add the package
name as a double quoted string to the `external-scripts.json` file in this repo.

## Deployment

    % heroku create --stack cedar
    % git push heroku master
    % heroku ps:scale app=1

If your Heroku account has been verified you can run the following to enable
and add the Redis to Go addon to your app.

    % heroku addons:add redistogo:nano

If you run into any problems, checkout Heroku's [docs][heroku-node-docs].

You'll need to edit the `Procfile` to set the name of your hubot.

More detailed documentation can be found on the
[deploying hubot onto Heroku][deploy-heroku] wiki page.

### Deploying to UNIX or Windows

If you would like to deploy to either a UNIX operating system or Windows.
Please check out the [deploying hubot onto UNIX][deploy-unix] and
[deploying hubot onto Windows][deploy-windows] wiki pages.

[heroku-node-docs]: http://devcenter.heroku.com/articles/node-js
[deploy-heroku]: https://github.com/github/hubot/wiki/Deploying-Hubot-onto-Heroku
[deploy-unix]: https://github.com/github/hubot/wiki/Deploying-Hubot-onto-UNIX
[deploy-windows]: https://github.com/github/hubot/wiki/Deploying-Hubot-onto-Windows

## Campfire Variables

If you are using the Campfire adapter you will need to set some environment
variables. Refer to the documentation for other adapters and the configuraiton
of those, links to the adapters can be found on the [hubot wiki][hubot-wiki].

Create a separate Campfire user for your bot and get their token from the web
UI.

    % heroku config:add HUBOT_CAMPFIRE_TOKEN="..."

Get the numeric IDs of the rooms you want the bot to join, comma delimited. If
you want the bot to connect to `https://mysubdomain.campfirenow.com/room/42` 
and `https://mysubdomain.campfirenow.com/room/1024` then you'd add it like this:

    % heroku config:add HUBOT_CAMPFIRE_ROOMS="42,1024"

Add the subdomain hubot should connect to. If you web URL looks like
`http://mysubdomain.campfirenow.com` then you'd add it like this:

    % heroku config:add HUBOT_CAMPFIRE_ACCOUNT="mysubdomain"

[hubot-wiki]: https://github.com/github/hubot/wiki

## Restart the bot

You may want to get comfortable with `heroku logs` and `heroku restart`
if you're having issues.

