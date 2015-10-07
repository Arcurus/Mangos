Template.nav.events 'click .logout': (event) ->
  event.preventDefault()
  Meteor.logout()
  return
