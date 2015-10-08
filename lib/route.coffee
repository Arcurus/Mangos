Router.configure layoutTemplate: 'layout'
Router.map ->
  @route 'people', path: '/people'
  @route 'register', path: '/register'
  @route 'login', path: '/login'
  @route 'home', path: '/'
  @route 'verifications', path: '/verifications'
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


#Redirect User when not Loggedin to the Login template
Router.onBeforeAction (->
  if !Meteor.userId()
    @render 'login'
  else
    @next()
  return
), except: [ 'register' ]
