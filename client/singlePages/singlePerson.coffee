Template.singlePerson.helpers
  transactions: ->
    Transactions.find(
      $or: [
        {sender: @_id}
        {receiver: @_id}
      ]
    )
  sender: ->
    Meteor.users.findOne @sender
  receiver: ->
    Meteor.users.findOne @receiver
  age: ->
    @years.toFixed(2)
Template.singlePerson.onRendered ->
  @$(".menu .item").tab()
