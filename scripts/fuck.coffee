# Description:
#   Ask hubot how many fucks a person has said so far.
#
# Commands:
#   hubot how many fucks?
#   hubot how many fucks has <user> given?
#
# Examples:
#   hubot how many fucks does mason give?

fuck_dict = {}

module.exports = (robot) ->

  robot.hear /fuck/i, (msg) ->
    fucks = (msg.message.text.match(/fuck/i) || []).length;
    user = msg.message.user.name
    old_fucks = 0
    old_fucks = fuck_dict[user] if fuck_dict[user]?
    old_fucks += fucks
    fuck_dict[user] = old_fucks

  robot.respond /how many fucks (has|does) @?([\w .\-]+) (said|given|give)\?*$/i, (msg) ->
    name = msg.match[2].trim()
    if fuck_dict[name]?
      msg.send "#{name} has given #{fuck_dict[name]} fuck(s)."
    else
      msg.send "#{name} doesn't give a fuck."

  robot.respond /how many fucks\?*$/i, (msg) ->
    for name, fucks of fuck_dict
      msg.send "#{name} has given #{fucks} fuck(s)."
      