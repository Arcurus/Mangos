Template.subActions.helpers
  actions: ->
    Actions.find {project: @_id},
      sort:
        createdAt: -1
  username: ->
    Meteor.users.findOne(@createdBy).username

Template.subActions.events
  'submit .addAction': (event) ->
    event.preventDefault()
    name = event.target.name.value
    min = Number(event.target.min.value)
    projectId = @._id
    console.log name + min + projectId
    Meteor.call 'addAction', name, min, projectId
