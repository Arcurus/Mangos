Template.registerHelper 'currentRouteIs', (route) ->
  Router.current().route.getName() == route

Template.nav.events 'click .logout': (event) ->
  event.preventDefault()
  Meteor.logout()
  return
