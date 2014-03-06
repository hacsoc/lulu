# Description
#   lulu recognizes the person who named her.
name = process.env.NAMER_NAME
name_re = new RegExp(name, 'i')

nick = process.env.NAMER_NICK
nick_re = new RegExp("^#{nick}$")

module.exports = (robot) ->
  robot.hear name_re, (msg) ->
    msg.send "#{name}!"

  robot.enter (msg) ->
    entered = msg.message.user.name.toLowerCase()
    if nick_re.test entered
      msg.send "hi #{entered}!"
