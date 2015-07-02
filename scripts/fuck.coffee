# Description:
#   Ask hubot how many fucks a person has said so far.
#
# Commands:
#   hubot how many fucks?
#   hubot how many fucks has <user> given?
#
# Examples:
#   hubot how many fucks does mason give?

module.exports = (robot) ->

  robot.hear /f+u+c+k+/i, (msg) ->
    fucks = (msg.message.text.match(/f+u+c+k+/i) || []).length;
    user = msg.message.user.name
    fuck_dict = robot.brain.get 'fucks'
    fuck_dict = {} if not fuck_dict
    old_fucks = fuck_dict[user]
    old_fucks = 0 if not fuck_dict[user]
    fucks += old_fucks
    fuck_dict[user] = fucks
    robot.brain.set 'fucks', fuck_dict
    robot.brain.save()

  robot.respond /how many fucks (has|does) @?([\w .\-]+) (said|given|give)\?*$/i, (msg) ->
    name = msg.match[2].trim()
    fuck_dict = robot.brain.get 'fucks'
    fuck_dict = {} if not fuck_dict
    if fuck_dict[name]?
      msg.send "#{name} has given #{fuck_dict[name]} fuck(s)."
    else
      msg.send "#{name} doesn't give a fuck."

  robot.respond /how many fucks\?*$/i, (msg) ->
    fuck_dict = robot.brain.get 'fucks'
    fuck_dict = {} if not fuck_dict
    fuck_list = ([name, fucks] for name, fucks of fuck_dict)
    fuck_list.sort((t1, t2) -> t2[1] - t1[1])
    fuck_list = fuck_list[..5]
    for tuple in fuck_list
      if tuple[1] == 1
        msg.send "#{tuple[0]} has given #{tuple[1]} fuck"
      else
        msg.send "#{tuple[0]} has given #{tuple[1]} fucks"
