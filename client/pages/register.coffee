Template.register.events 'submit form': (event) ->
  event.preventDefault()
  Accounts.createUser {
    username: $('[name=username]').val()
    password: $('[name=password]').val()
  }, (error) ->
    if error
      alert error.reason
      # Output error if registration fails
    else
      Router.go 'home'
      # Redirect user if registration succeeds
    return

  'click .facebook-login': (event) ->
    Meteor.loginWithFacebook {}, (err) ->
      if err
        error.reason
      else
        Router.go 'home'
