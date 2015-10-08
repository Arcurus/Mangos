Template.singlePerson.helpers
  transactions: ->
    Transactions.find(
      $or: [
        {from: @._id}
        {receiver: @_id}
      ]
    )
  sender: ->
    Meteor.users.findOne @.from
  receiver: ->
    Meteor.users.findOne @.receiver


