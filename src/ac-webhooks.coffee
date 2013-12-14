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
    data = JSON.parse req.body['data']
    console.log data
    data = data['data']
    timeRecord = data['time_record']
    billableStatus = 'billable'
    projectId = timeRecord['parent_id']
    if timeRecord['billable_status'] != 1 then billableStatus = 'non billable'
    userName = timeRecord['user_name']
    time = timeRecord['value']
    user = {}
    user.room = process.env['HUBOT_CAMPFIRE_ROOMS'].split(',')[0]
    robot.send user, userName + ' logged ' + time + ' ' + billableStatus + ' hours against ' + projectId 
    res.end '{"success":true}'
