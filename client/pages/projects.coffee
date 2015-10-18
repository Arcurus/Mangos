Template.projects.helpers
  projects: ->
    Projects.find {},
      sort:
        totalTime: -1
  createdBy: ->
    Meteor.users.findOne @createdBy
  peopleCount: ->
    Shares.find({project: @_id}).count()
  transactionsCount: ->
    Transactions.find({project: @_id}).count()
  actionsCount: ->
    Actions.find({project: @_id}).count()
  messageCount: ->
    Messages.find({project: @_id}).count()
  totalMangos: ->
    array = Transactions.find({project: @_id}).fetch()
    console.log array
    total = 0
    for transfers, i in array
      total += array[i].mangos
      console.log total
    return total.toFixed(2)

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
