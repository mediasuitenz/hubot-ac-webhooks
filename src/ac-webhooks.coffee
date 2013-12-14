# Description:
#  Listens for ac webhooks and post in chat
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Notes:
#   None
#
# Author:
#   digitalsadhu
module.exports = (robot) ->

  robot.router.post "/hubot/ac-webhooks", (req, res) ->
    console.log req.body
    user = {}
    user.room = process.env['HUBOT_CAMPFIRE_ROOMS'].split(',')[0]
    robot.send user, 'ac webhooks url hit!'
    res.end '{"success":true}'