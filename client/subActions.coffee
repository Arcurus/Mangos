Template.subActions.helpers
  actions: ->
    actionA = []
    for actions, i in @actions
      Actions.findOne @actions[i]

Template.subActions.events
  'submit .addAction': (event) ->
    event.preventDefault()
    name = event.target.name.value
    min = Number(event.target.min.value)
    projectId = @._id
    console.log name + min + projectId
    Meteor.call 'addAction', name, min, projectId
