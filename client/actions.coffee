Template.actions.helpers
  actions: ->
    Actions.find(),
      sort:
        createdAt: -1
  project: ->
    Projects.findOne @project
  createdBy: ->
    Meteor.users.findOne @createdBy
