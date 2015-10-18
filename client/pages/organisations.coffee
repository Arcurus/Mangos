Template.organisations.helpers
  organisations: ->
    Organisations.find {},
      sort:
        createdAt: 1
  createdBy: ->
    Meteor.users.findOne @createdBy
  peopleCount: ->
    Shares.find({project: @_id}).count()
  messageCount: ->
    Messages.find({project: @_id}).count()

Template.organisations.onRendered ->
  $('.addOrganisation').validate
    rules:
      name:
        required: true
        minlength: 3
        maxlength: 50
    messages:
      name:
        minlength: "Minimum 3 Characters, be more creative"
        maxlength: "Maximum 50 Characters, be less creative"

Template.organisations.events
  'submit .addOrganisation': (event) ->
    event.preventDefault()
    name = event.target.name.value
    Meteor.call 'addOrganisation', name
    event.target.name.value = null
