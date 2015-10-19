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

