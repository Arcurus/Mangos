Template.subPeople.helpers
  shares: ->
    Shares.find {project: @_id}
  percent: ->
    totalTime = Projects.findOne(@project).totalTime
    (@totalTime / totalTime * 100).toFixed(3)
  createdBy: ->
    Meteor.users.findOne @createdBy
