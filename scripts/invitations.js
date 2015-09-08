// Description:
//   Invite users who mess up their join command.
//
// Commands:
//   join #ieee - hubot will invite you to #ieee

module.exports = function(robot) {

    // We only want to register the "hear" callback for the IRC adapter, since
    // we're relying so heavily on the IRC implementation details.
    if (robot.adapterName !== "irc")
        return;

    robot.hear(/join +([&#!+][^ ,\07]+)$/, function(msg) {

        // Get channel and user information.
        var channel = msg.match[1];
        var user = msg.message.user.name;

        // NOTE: this depends on implementation details of the IRC adapter, and
        // the Irc.Client implementation used by the IRC adapter.  It has no
        // chance of working on any other adapter :P
        if (channel in robot.adapter.bot.chans) {
            // If we're in the channel, just invite them in.
            robot.adapter.command('INVITE', user, channel);
        } else {
            // Otherwise, briefly join, invite, and leave.
            robot.adapter.join(channel);
            robot.adapter.command('INVITE', user, channel);
            robot.adapter.part(channel);
        }
    });

};
