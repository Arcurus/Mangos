Template.singleOrganisation.helpers
  username: ->
    Meteor.users.findOne(@createdBy).username
  transactionsCount: ->
    Transactions.find({organisation: @_id}).count()
  projectCount: ->
    Projects.find({organisation: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()

Template.singleOrganisation.events
  'click .menu .item': ->
    $(".menu .item").tab()
