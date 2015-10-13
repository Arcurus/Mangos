Template.subPeople.helpers
  shares: ->
    Shares.find {project: @_id}
  percent: ->
    totalMin = Projects.findOne(@project).totalMin
    (@min / totalMin * 100).toFixed(3)
  username: ->
    Meteor.users.findOne(@createdBy).username
