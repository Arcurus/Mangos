Template.singlePerson.helpers
  transactions: ->
    sender = {from: @._id}
    Transactions.find sender
