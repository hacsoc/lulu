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

With the dual legacy availability of scripts for hubot, lulu makes use of both
the now-deprecated [external-scripts][external-scripts] and the legacy-
but-available [hubot-scripts][hubot-scripts]. Any bugs in these scripts should
be properly reported to the appropriate maintainer (if none exists, why not take
over? Easy, right? >.>).

To enable scripts from the hubot-scripts package, add the script name with
extension as a double quoted string to the `hubot-scripts.json` file in this
repo. Similarly, to add scripts from the hubot-scripts *project*, add the script
name with*out* extension as a double quoted string to the
`external-scripts.json` file in this repo. See the next section for further
information about using external scripts.

[hubot-scripts]: https://github.com/github/hubot-scripts
[external-scripts]: https://github.com/hubot-scripts/

## external-scripts

Hubot is now able to load scripts from third-party `npm` packages! To enable
this functionality you can follow the following steps.

1. Add the packages as dependencies into your `package.json`
2. `npm install` to make sure those packages are installed

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
- `HUBOT_REDMINE_BASE_URL`
- `HUBOT_REDMINE_TOKEN`
- `REDIS_URL`
- `NAMER_NAME`
- `NAMER_NICK`

