# Publish all Users
Meteor.publish 'allPeople', ->
  Meteor.users.find()
