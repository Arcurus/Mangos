Template.subTransactions.helpers
  transactions: ->
    Transactions.find {receiver: @_id}
