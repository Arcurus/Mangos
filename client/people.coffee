Template.people.helpers
  users: ->
    Meteor.users.find {},
      sort:
        account: -1
  fullname: ->
    @.profile.name
  profilePicture: ->
    @.profile.picture
  peopleCount: ->
    Meteor.users.find().count()
  peopleVerified: ->
    Meteor.users.find({verified: true}).count()
  account: ->
    @account.toFixed(4)
  gbi: ->
    @gbi.toFixed(10)
