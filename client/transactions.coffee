Template.transactions.helpers
  transactions: ->
    Transactions.find {},
      sort:
        createdAt: -1
  selectedPerson: ->
    Session.get 'ReceiverId'

  settings: ->
    {
      position: 'bottom'
      limit: 10
      rules: [ {
        collection: Meteor.users
        field: 'profile.name'
        matchAll: true
        template: Template.standardLegends
      } ]
    }
  username: ->
    Meteor.users.findOne(@.from).profile.name
  receiver: ->
    Meteor.users.findOne(@.receiver).profile.name

Template.transactions.onRendered ->
  $('#transfer').validate
    rules:
      amount:
        required: true
        min: 0.0001
        number: true
        max: (event) ->
          Meteor.user().mangos

Template.transactions.events
  'autocompleteselect input': (event, template, doc) ->
    Session.set 'ReceiverId', doc._id
    return
  'submit .addTransaction': (event) ->
    event.preventDefault()
    receiver = Session.get 'ReceiverId'
    amount = Number(event.target.amount.value)
    amountPoints = amount * Meteor.user().points / Meteor.user().mangos
    Meteor.call 'addTransaction', receiver, amountPoints
    return



