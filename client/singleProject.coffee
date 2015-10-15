Template.singleProject.helpers
  username: ->
    Meteor.users.findOne(@createdBy).username

Template.singleProject.events
  'click .menu .item': ->
    $(".menu .item").tab()
