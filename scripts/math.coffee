# Description:
#   Allows Hubot to do mathematics.
#
# Commands:
#   hubot math me <expression> - Calculate the given expression.
#   hubot convert me <expression> to <units> - Convert expression to given units.

math = require('mathjs')
module.exports = (robot) ->
  robot.respond /(calc|calculate|convert|math)( me)? (.*)/i, (msg) ->
    msg.send math.eval(msg.match[3])
