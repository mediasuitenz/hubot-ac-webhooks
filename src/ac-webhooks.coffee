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

ac = require('node-activecollab').init process.env.AC_API_URL, process.env.AC_API_KEY

module.exports = (robot) ->

  robot.router.post "/hubot/ac-webhooks", (req, res) ->

    ac.apiUrl.check (state) ->
        console.log state

    data = JSON.parse req.body['data']
    console.log data
    data = data['data']
    timeRecord = data['time_record']
    
    billableStatus = 'billable'
    if timeRecord['billable_status'] != 1 then billableStatus = 'non billable'

    userName = timeRecord['user_name']
    time = timeRecord['value']
    projectType = timeRecord['parent_type']
    jobTypeId = timeRecord['job_type_id']
    summary = timeRecord['summary']
    parentId = timeRecord['parent_id']
    
    user = {}
    user.room = process.env['HUBOT_CAMPFIRE_ROOMS'].split(',')[0]

    ac.project parentId, (project) ->
        robot.send user, userName + ' logged ' + time + ' ' + billableStatus + ' hours against ' + projectType + ' ' + project['name'] + ' (' + summary + ')'
        res.end '{"success":true}'


