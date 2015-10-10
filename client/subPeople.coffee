Template.subPeople.helpers
  person: ->
    user = Meteor.users.findOne(@person)
    user.profile.name
