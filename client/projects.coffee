Template.projects.helpers
  projects: ->
    Projects.find()

Template.projects.events
  'submit .addProject': (event) ->
    event.preventDefault()
    name = event.target.name.value
    Meteor.call 'addProjects', name
