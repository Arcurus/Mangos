Template.singleOrganisation.helpers
  username: ->
    Meteor.users.findOne(@createdBy).username
  transactionsCount: ->
    Transactions.find({organisation: @_id}).count()
  projectCount: ->
    Projects.find({organisation: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()

Template.singleOrganisation.onRendered ->
  @$('textarea').autosize()
  $('.payProject').validate
    rules:
      amount:
        required: true
        min: 0
        max: (event) ->
          Meteor.user().mangos
        number: true
      message:
        minlength: 1
        maxlength: 120
    messages:
      amount:
        min: "You are cheeky"

Template.singleOrganisation.events
  'click .menu .item': ->
    $(".menu .item").tab()
  'submit .payOrganisation': (event) ->
    event.preventDefault()
    amount = event.target.amount.value
    message = event.target.message.value
    organisationId = @._id
    Meteor.call 'payOrganisation', organisationId, amount, message
    event.target.message.value = null
    event.target.amount.value = null
    return


