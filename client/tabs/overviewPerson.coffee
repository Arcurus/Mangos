Template.overviewPerson.helpers
  mangos: ->
    @mangos.toFixed(3)
  totalTime: ->
    array = Shares.find({createdBy: @_id}).fetch()
    console.log array
    total = 0
    for time, i in array
      total += array[i].totalTime
      console.log total
    return total
  actionsCount: ->
    Actions.find({createdBy: @_id}).count()
  messageCount: ->
    Messages.find({createdBy: @_id}).count()
  transactions: ->
    Transactions.find { $or: [
      { sender: @_id }
      { receiver: @_id }
    ]}, sort: createdAt: -1
  sender: ->
    Meteor.users.findOne @sender
  receiver: ->
    Meteor.users.findOne @receiver
  receiverOrga: ->
    Organisations.findOne @receiver
