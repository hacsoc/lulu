# lulu

[![forthebadge](http://forthebadge.com/images/badges/powered-by-case-western-reserve.svg)](http://forthebadge.com)

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
an implementation of Redis in some way or another and the appropriate configuration. For further information, see [hubot-redis-brain doc](https://www.npmjs.com/package/hubot-redis-brain).

For remote redis, the URL must be formatted as `redis://:password@address.com:port/prefix`
by experimental testing. Note the unexpected additional `:`.

## Testing Hubot Locally

To get started with hubot, you will need `node.js` and its associated package
manager `npm`. Downloading `node.js` [directly][nodedownload] or through your
favorite package manage, likely as `nodejs` and `npm`.

Once you have the runtime installed, [fork this repo][forklulu] and clone to
your development computer. In the root of the repo, run `npm install` to install
all of the dependencies in `package.json`.

With all the dependencies installed, run `bin/hubot` to start shell interaction.
You'll see some start up output about where your scripts come from and a prompt.
Some status or error messages are expected if environment variables are not
fully configured.

Then you can start interacting with hubot by typing anything that may be picked
up by a listener. Run `hubot help .*` (the shell will *not* respond to the name
`lulu`) to generate a list of available commands. This may have a very long
output due to the number of scripts installed.

[nodedownload]: https://nodejs.org/download/
[forklulu]: https://github.com/cwruacm/lulu/fork

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

## external-scripts

Hubot is now able to load scripts from third-party `npm` packages! To enable
this functionality you can follow the following steps.

1. Add the packages as dependencies into your `package.json`
2. `npm install` to make sure those packages are installed

More easily, you can skip manually managing the dependency list and manage the
correct dependencies using `npm install --save [package-name]`. This will update
`package.json` for you. However, if there are version restrictions on the
dependency you are adding, be sure to update the `package.json` to reflect the
requirement.

To enable third-party scripts that you've added you will need to add the package
name as a double quoted string to the `external-scripts.json` file in this repo.

Any new scripts that you want to make generally available should be implemented
as independent repositories that are connected to `npm`.

## Deployment

Check `DOCUMENTATION` for information on deploying lulu. This generally will
require setting the appropriate environment variables before running `bin/hubot`
with any appropriate parameters.

### Expected Environment Variables

Deploying lulu currently expects the following environment variables to be set.
This should be done by the un-committed script with requisite
keys/passwords/tokens that lives on irc.case.edu.

- `HUBOT_HOME`
- `HUBOT_IRC_NICK`
- `HUBOT_IRC_ROOMS`
- `HUBOT_IRC_SERVER`
- `HUBOT_DNSIMPLE_USERNAME`
- `HUBOT_DNSIMPLE_API_TOKEN`
- `HUBOT_YOUTUBE_API_KEY`
- `HUBOT_YOUTUBE_DETERMINISTIC_RESULTS` (optional flag)
- `REDIS_URL` (optional if redis is hosted at `localhost:6379` relative to lulu)
- `NAMER_NAME`
- `NAMER_NICK`
- `HUBOT_WEB_TITLE_LEN` (optional, int for maximum length of web titles. defaults to 200)
