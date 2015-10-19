Template.subProjects.helpers
  projects: ->
    Projects.find organisations: @_id
  projectsSelect: ->
    Projects.find organisations: $ne: @_id,
      sort:
        name: 1
  id: ->
    Session.set 'orgaId', @_id
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

Template.subProjects.onRendered ->
  @$('.dropdown').dropdown
    onChange: (value) ->
      Meteor.call 'addProjectToOrga', value, Session.get 'orgaId'
      $('.dropdown').dropdown('restore default')

Template.subProjects.events
  "submit .addProject": (event) ->
    event.preventDefault()
    projectId = event.target.name.value
    alert projectId.name
    orgaId = @_id
    ###Meteor.call 'addProjectToOrga', projectId
    Session.set 'ProjectId', null
    event.target.name.value = null
    return###



