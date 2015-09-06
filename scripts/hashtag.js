// Description:
//   Tracks how many times each hashtag has been used.
//
// Commands:
//   #[any_hashtag] - hears and counts hashtags
//   hubot hashtags - show top 5 hashtags
//   hubot hashtag [hashtag] - show how many times a hashtag is used

module.exports = function(robot) {

    robot.hear(/#\w+/, function(msg) {
        counts = robot.brain.get('hashtags');
    });

    robot.respond(/hashtags/i, function(msg) {

    });

};
