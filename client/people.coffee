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
    @percent.toFixed(3)
  mangos: ->
    @mangos.toFixed(3)
  points: ->
    @points.toFixed(3)
  years: ->
    @years.toFixed(3)
  verifiedAt: ->
    @verifiedAt.toFixed(3)
