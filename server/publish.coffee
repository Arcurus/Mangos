# Publish all Users
Meteor.publish 'People', ->
  Meteor.users.find()

Meteor.publish 'Transactions', ->
  Transactions.find()

Meteor.publish 'Projects', ->
  Projects.find()
