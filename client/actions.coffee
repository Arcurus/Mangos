Template.actions.helpers
  actions: ->
    Actions.find()
  project: ->
    Projects.findOne @project
  createdBy: ->
    Meteor.users.findOne @createdBy
