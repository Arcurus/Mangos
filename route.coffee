Router.configure layoutTemplate: 'layout'
Router.map ->
  @route 'people', path: '/people'
  @route 'home', path: '/'
  @route 'singlePerson',
    path: '/people/:_id'
    data: ->
      Meteor.users.findOne @params._id
  @route 'transactions', path: '/transactions'
  @route 'projects', path: '/projects'
  @route 'singleProject',
    path: '/projects/:_id'
    data: ->
      Projects.findOne @params._id

