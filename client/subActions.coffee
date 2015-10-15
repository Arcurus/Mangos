Template.subActions.helpers
  actions: ->
    Actions.find {project: @_id},
      sort:
        createdAt: -1
  username: ->
    Meteor.users.findOne(@createdBy).username

Template.subActions.onRendered ->
  $('.addAction').validate
    rules:
      min:
        required: true
        min: 0
        max: 120
        number: true
      name:
        required: true
        minlength: 5
        maxlength: 120
    messages:
      min:
        max: "Max 120 min, you can not concentrate that long on one task"
        min: "You are cheeky"


Template.subActions.events
  'submit .addAction': (event) ->
    event.preventDefault()
    name = event.target.name.value
    min = Number(event.target.min.value)
    projectId = @._id
    Meteor.call 'addAction', name, min, projectId
