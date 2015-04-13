# Description:
#   An auto-responder for identity-like queries
#
# Commands:
#   listens for "who is " followed by the bot name
bot_name = process.env.HUBOT_IRC_NICK or 'hubot'

identity_request = new RegExp("((who)|(what)).* is " + bot_name, "i")

bot_location = "https://github.com/cwruacm/lulu"

module.exports = (robot) ->
  robot.hear identity_request, (msg) ->
    msg.send "I am #{bot_name}. My source lives at " + bot_location
