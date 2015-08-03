Router.configure layoutTemplate: 'layout'
Router.map ->
  @route 'people', path: '/people'
  @route 'home', path: '/'
  @route 'singlePerson',
    path: '/people/:_id'
    data: ->
      Meteor.users.findOne @params._id
