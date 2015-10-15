Template.people.helpers
  users: ->
    Meteor.users.find {},
      sort:
        mangos: -1
  profilePicture: ->
    @profile.picture
  peopleCount: ->
    Meteor.users.find().count()
  peopleVerified: ->
    Meteor.users.find(verified: true).count()
  percent: ->
    @percent.toFixed(3)
  points: ->
    @points.toFixed(3)
  mangos: ->
    @mangos.toFixed(3)
  years: ->
    @years.toFixed(3)
  userVerified: ->
    Meteor.user().verified
  timeTillExpiration: ->
    time = 5 - (@years - @verifiedAt)
    return time.toFixed(2)
  allowed: ->
    if(@verifyLevel > 0)
      return true

Template.people.events
  'click .verify': ->
    Meteor.call 'verifyPerson' , @._id




