Template.verifications.helpers
  verifications: ->
    Verifications.find {},
      sort:
        createdAt: -1

  createdBy: ->
    Meteor.users.findOne(@createdBy).username
  verifiedPerson: ->
    Meteor.users.findOne(@verifiedPerson).username
  verifiedAt: ->
    @verifiedAt.toFixed(2)
