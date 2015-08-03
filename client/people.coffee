Template.people.helpers
  users: ->
    Meteor.users.find()
  username: ->
    Meteor.users.findOne(@_id).profile.name
  profilePicture: ->
    Meteor.users.findOne(@_id).profile.picture
  peopleCount: ->
    Meteor.users.find().count()
