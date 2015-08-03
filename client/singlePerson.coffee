Template.singlePerson.helpers
  username: ->
    Meteor.users.findOne(@_id).profile.name
  profilePicture: ->
    Meteor.users.findOne(@_id).profile.picture
