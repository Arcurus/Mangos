Template.subMessages.helpers
  messages: ->
    Messages.find {childOf: @_id},
      sort:
        createdAt: -1
  createdBy: ->
    Meteor.users.findOne @createdBy

Template.subMessages.onRendered ->
  $('.addMessage').validate
    rules:
      message:
        minlength: 2
        maxlength: 500
    messages:
      amount:
        minlength: "Come on, at least two letters"
        maxlength: "We don't like long texts, keep it short and simple"


Template.subMessages.events
  'submit .addMessage': (event) ->
    event.preventDefault()
    message = event.target.message.value
    projectId = @._id
    Meteor.call 'addMessage', projectId, message
    event.target.message.value = null




