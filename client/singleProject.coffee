Template.singleProject.helpers
  username: ->
    Meteor.users.findOne(@createdBy).username
  peopleCount: ->
    Shares.find({project: @_id}).count()
  transactionsCount: ->
    Transactions.find({project: @_id}).count()
  actionsCount: ->
    Actions.find({project: @_id}).count()

Template.singleProject.events
  'click .menu .item': ->
    $(".menu .item").tab()
