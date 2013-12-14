# Description:
#  Listens for ac webhooks and post in chat, Currently only interested in time
#  logs
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

    # Get the data out of the request body
    data = JSON.parse req.body['data']
    data = data['data']
    timeRecord = data['time_record']
    
    # Handle billability
    billableStatus = 'billable'
    if timeRecord['billable_status'] != 1 then billableStatus = 'non billable'

    # Collect other time record values
    userName = timeRecord['user_name']
    time = timeRecord['value']
    projectType = timeRecord['parent_type']
    jobTypeId = timeRecord['job_type_id']
    summary = timeRecord['summary']
    parentId = timeRecord['parent_id']
    projectName = timeRecord['project_name']
    taskName = timeRecord['task_name']
    
    # if time was logged against a task we handle slightly differently from if
    # time was logged against a project
    taskMessage = ''
    if typeof taskName != 'undefined' then taskMessage = 'task ' + taskName + ' for the '

    # Build the final message to put into the chat room
    message = userName + ' logged ' + time + ' ' + billableStatus + ' hours against the ' + 
      taskMessage + 'project ' + projectName + ' with the description ' + summary

    # We need to know which chat room to log to, set that up
    user = {}
    user.room = process.env['HUBOT_CAMPFIRE_ROOMS'].split(',')[0]

    # Send the message
    robot.send user, message

    # Terminate the request, return true status for whoever called the endpoint
    res.end '{"success":true}'


