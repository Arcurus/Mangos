#Publish all Users
Meteor.publish 'People', ->
  Meteor.users.find()
#Publish all Transactions
Meteor.publish 'Transactions', ->
  Transactions.find()
#Publish all Projects
Meteor.publish 'Projects', ->
  Projects.find()
#Publish all Verifications
Meteor.publish 'Verifications', ->
  Verifications.find()
