Template.subOverview.helpers
  shares: ->
    Shares.find {project: @_id}
  createdBy: ->
    Meteor.users.findOne @createdBy
  user: ->
    Meteor.users.findOne(@createdBy)
  peopleCount: ->
    Shares.find({project: @_id}).count()
  transactionsCount: ->
    Transactions.find({project: @_id}).count()
  actionsCount: ->
    Actions.find({project: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
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
