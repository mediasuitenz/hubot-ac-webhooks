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

  robot.router.get "/hubot/ac-webhooks", (req, res) ->
    robot.send "ac webhooks url hit!"