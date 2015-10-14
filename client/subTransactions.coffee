Template.subTransactions.helpers
  transactions: ->
    Transactions.find {project: @_id},
      sort:
        createdAt: -1
  receiver: ->
    Meteor.users.findOne(@receiver).username
  sender: ->
    Meteor.users.findOne(@sender).username
  project: ->
    Projects.findOne(@project).name
  mangos: ->
    @mangos.toFixed(3)

Template.subTransactions.events
  'submit .payProject': (event) ->
    event.preventDefault()
    amount = Number(event.target.amount.value)
    message = event.target.message.value
    projectId = @._id
    Meteor.call 'payProject', projectId, amount, message
    Session.set 'ReceiverId', null
    event.target.message.value = null
    event.target.amount.value = null
    return



