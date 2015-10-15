Template.projects.helpers
  projects: ->
    Projects.find()
  createdBy: ->
    Meteor.users.findOne @createdBy

Template.projects.onRendered ->
  $('.addProject').validate
    rules:
      name:
        required: true
        minlength: 3
        maxlength: 50
    messages:
      name:
        minlength: "Minimum 3 Characters, be more creative"
        maxlength: "Maximum 50 Characters, be less creative"

Template.projects.events
  'submit .addProject': (event) ->
    event.preventDefault()
    name = event.target.name.value
    Meteor.call 'addProjects', name
    event.target.name.value = null
