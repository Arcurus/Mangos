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

Template.subOverview.onRendered ->
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

Template.subOverview.events
  'submit .payProject': (event) ->
    event.preventDefault()
    amount = event.target.amount.value
    message = event.target.message.value
    projectId = @._id
    Meteor.call 'payProject', projectId, amount, message
    event.target.message.value = null
    event.target.amount.value = null
    return


