# Description:
#   Ask hubot how many fucks a person has said so far.
#
# Commands:
#   hubot how many fucks?
#   hubot how many fucks has <user> said?
#
# Examples:
#   hubot how many fucks has mason said?

fuck_dict = {}

module.exports = (robot) ->

  robot.hear /fuck/i, (msg) ->
    fucks = (msg.message.text.match(/fuck/i) || []).length;
    user = msg.message.user.name
    old_fucks = 0
    old_fucks = fuck_dict[user] if fuck_dict[user]?
    old_fucks += fucks
    fuck_dict[user] = old_fucks

  robot.respond /how many fucks has @?([\w .\-]+) said\?*$/i, (msg) ->
    name = msg.match[1].trim()
    if fuck_dict[name]?
      msg.send "#{name} has said fuck #{fuck_dict[name]} times."
    else
      msg.send "I haven't heard #{name} say fuck yet."

  robot.respond /how many fucks\?*$/i, (msg) ->
    for name, fucks of fuck_dict
      msg.send "#{name} has said fuck #{fucks} times."