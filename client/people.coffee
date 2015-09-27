Template.people.helpers
  users: ->
    Meteor.users.find {},
      sort:
        points: -1
  profilePicture: ->
    @.profile.picture
  peopleCount: ->
    Meteor.users.find().count()
  peopleVerified: ->
    Meteor.users.find(verified: true).count()
  percent: ->
    @percent.toFixed(6)
  mangos: ->
    @mangos.toFixed(3)
  points: ->
    @points.toFixed(6)
  years: ->
    @years.toFixed(3)
