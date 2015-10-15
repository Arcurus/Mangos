Template.subTransactions.helpers
  transactions: ->
    Transactions.find {project: @_id},
      sort:
        createdAt: -1
  receiver: ->
    Meteor.users.findOne(@receiver)
  sender: ->
    Meteor.users.findOne(@sender)
  project: ->
    Projects.findOne(@project).name
  mangos: ->
    @mangos.toFixed(3)

Template.subTransactions.onRendered ->
  $('.payProject').validate
    rules:
      amount:
        required: true
        min: 0
        max: (event) ->
          Meteor.user().mangos
        number: true
      message:
        minlength: 1
        maxlength: 120
    messages:
      amount:
        min: "You are cheeky"

Template.subTransactions.events
  'submit .payProject': (event) ->
    event.preventDefault()
    amount = event.target.amount.value
    message = event.target.message.value
    projectId = @._id
    Meteor.call 'payProject', projectId, amount, message
    Session.set 'ReceiverId', null
    event.target.message.value = null
    event.target.amount.value = null
    return



