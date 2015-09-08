// Description:
//   Tracks how many times each hashtag has been used.
//
// Commands:
//   #[any_hashtag] - hears and counts hashtags
//   hubot hashtags - show top 5 hashtags
//   hubot hashtag [hashtag] - show how many times a hashtag is used
//
// Examples:
//   I love #tswift!
//   hubot hashtag tswift

module.exports = function(robot) {

    robot.hear(/#\w+/g, function(msg) {
        // Retrieve hashtag object.
        var counts = robot.brain.get('hashtags');

        // Create it if it doesn't exist.
        if (counts === undefined || counts === null) {
            counts = {};
        }

        // Increment or set hashtag count to 1 for each hashtag in message.
        for (var i = 0; i < msg.match.length; i++) {
            if (msg.match[i] in counts) {
                counts[msg.match[i]] += 1;
            } else {
                counts[msg.match[i]] = 1;
            }
        }

        // Save updated counts in brain.
        robot.brain.set('hashtags', counts);
    });

    robot.respond(/hashtags/i, function(msg) {
        // Retrieve the hashtag object.
        counts = robot.brain.get('hashtags');

        // Create it if it doesn't exist.
        if (counts === undefined || counts === null) {
            counts = {};
        }

        // Convert object to array of pairs.
        list = [];
        for (hashtag in counts) {
            list.push([hashtag, counts[hashtag]]);
        }

        // Sort list by hashtag count and display top 5.
        list.sort(function(a, b) { return b[1] - a[1]; });
        list = list.slice(0, 5);
        for (var i = 0; i < list.length; i++) {
            msg.send(list[i][0] + ": " + list[i][1]);
        }
    });

    robot.respond(/hashtag #?(\w+)/i, function(msg) {
        // Retrieve hashtag object.
        var counts = robot.brain.get('hashtags');

        // Create it if it doesn't exist.
        if (counts === undefined || counts === null) {
            counts = {};
        }

        // Get counts and respond.
        var hashtag = '#' + msg.match[1];
        if (hashtag in counts) {
            msg.send(hashtag + ' has been used ' + counts[hashtag] + ' times.');
        } else {
            msg.send(hashtag + ' is not trending.');
        }
    });

};
