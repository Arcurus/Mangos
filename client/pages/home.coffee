Template.home.helpers
  totalVerifiedPeople: ->
    Meteor.users.find(verified: true).count()
  totalTransactions: ->
    Transactions.find().count()

