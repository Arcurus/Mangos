Template.subTransactions.helpers
  transactions: ->
    receiver = {receiver: @_id}
    Transactions.find receiver
