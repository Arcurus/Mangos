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
#Publish all Actions
Meteor.publish 'Actions', ->
  Actions.find()
#Publish all Shares
Meteor.publish 'Shares', ->
  Shares.find()
#Publish all Messages
Meteor.publish 'Messages', ->
  Messages.find()
#Publish all Organisations
Meteor.publish 'Organisations', ->
  Organisations.find()
