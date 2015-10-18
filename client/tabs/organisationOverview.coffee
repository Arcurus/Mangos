Template.organisationOverview.helpers
  user: ->
    Meteor.users.findOne(@createdBy)
  transactionsCount: ->
    Transactions.find({organisation: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  totalMangos: ->
    @mangos.toFixed(3)
  transactions: ->
    Transactions.find {organisation: @_id},
      sort:
        createdAt: -1
  receiver: ->
    Organisations.findOne(@receiver)
  sender: ->
    Meteor.users.findOne(@sender)
  organisation: ->
    Organisations.findOne(@organisation).name
  mangos: ->
    @mangos.toFixed(3)

Template.organisationOverview.onRendered ->
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

Template.organisationOverview.events
  'submit .payOrganisation': (event) ->
    event.preventDefault()
    amount = event.target.amount.value
    message = event.target.message.value
    organisationId = @._id
    Meteor.call 'payOrganisation', organisationId, amount, message
    event.target.message.value = null
    event.target.amount.value = null
    return


