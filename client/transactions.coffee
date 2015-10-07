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
        field: 'username'
        matchAll: true
        template: Template.searchUserDropDown
        noMatchTemplate: Template.noMatch
      } ]
    }
  username: ->
    Meteor.users.findOne(@.from).username
  receiver: ->
    Meteor.users.findOne(@.receiver).username

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
    message = event.target.message.value
    Meteor.call 'addTransaction', receiver, amount, message
    return



