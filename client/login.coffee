Template.login.events
  'submit form': (event) ->
    event.preventDefault()
    username = $('[name=username]').val()
    password = $('[name=password]').val()
    Meteor.loginWithPassword username, password, (error) ->
      if error
        alert error.reason
      else
        Router.go 'home'
      return

  'click .facebook-login': (event) ->
    Meteor.loginWithFacebook {}, (err) ->
      if err
        error.reason
      else
        Router.go 'home'
