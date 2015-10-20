Template.transactions.helpers
  transactions: ->
    Transactions.find {},
      sort:
        createdAt: -1
  createdAt: ->
    time = new Date(@createdAt).toDateString()
    time.substr 0, time.length - 4

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
  sender: ->
    Meteor.users.findOne(@.sender)
  receiver: ->
    Meteor.users.findOne(@.receiver)
  organisation: ->
    Organisations.findOne(@.receiver)
  mangos: ->
    @mangos.toFixed(3)
  project: ->
    Projects.findOne(@project)

Template.transactions.onRendered ->
  $('#transfer').validate
    rules:
      amount:
        max: (event) ->
          Meteor.user().mangos
        number: true
        required: true
        min: 0
      receiver:
        required: true
        goodReceiver: true

Template.transactions.events
  'autocompleteselect input': (event, template, doc) ->
    Session.set 'ReceiverId', doc._id
    return
  'submit .addTransaction': (event) ->
    event.preventDefault()
    receiver = Session.get 'ReceiverId'
    amount = event.target.amount.value
    message = event.target.message.value
    Meteor.call 'addTransaction', receiver, amount, message
    Session.set 'ReceiverId', null
    event.target.receiver.value = null
    event.target.message.value = null
    event.target.amount.value = null
    return



