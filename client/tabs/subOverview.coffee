Template.subOverview.helpers
  user: ->
    Meteor.users.findOne(@createdBy)
  peopleCount: ->
    Shares.find({project: @_id}).count()
  transactionsCount: ->
    Transactions.find({project: @_id}).count()
  actionsCount: ->
    Actions.find({project: @_id}).count()
  messageCount: ->
    Messages.find({project: @_id}).count()
  totalMangos: ->
    array = Transactions.find({project: @_id}).fetch()
    console.log array
    total = 0
    for transfers, i in array
      total += array[i].mangos
      console.log total
    return total.toFixed(2)
  totalTime: ->
    array = Shares.find({project: @_id}).fetch()
    console.log array
    total = 0
    for time, i in array
      total += array[i].totalTime
      console.log total
    return total
