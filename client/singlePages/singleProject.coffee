Template.singleProject.helpers
  maintainer: ->
    Meteor.users.findOne(@createdBy)
  peopleCount: ->
    Shares.find({project: @_id}).count()
  transactionsCount: ->
    Transactions.find({project: @_id}).count()
  actionsCount: ->
    Actions.find({project: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()

Template.singleProject.onRendered ->
  @$('textarea').autosize()
  @$(".menu .item").tab()
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

Template.singleProject.events
  'submit .payProject': (event) ->
    event.preventDefault()
    amount = event.target.amount.value
    message = event.target.message.value
    projectId = @._id
    Meteor.call 'payProject', projectId, amount, message
    event.target.message.value = null
    event.target.amount.value = null
    return


