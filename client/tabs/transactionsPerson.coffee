Template.transactionsPerson.helpers
  transactions: ->
    Transactions.find { $or: [
      { sender: @_id }
      { receiver: @_id }
    ]}, sort: createdAt: -1
  mangos: ->
    @mangos.toFixed(3)
  sender: ->
    Meteor.users.findOne @sender
  receiver: ->
    Meteor.users.findOne @receiver
  receiverOrga: ->
    Organisations.findOne @receiver
