Template.home.helpers
  totalMangos: ->
    peopleA = Meteor.users.find({verified: true}).fetch()
    sumPeople = 0
    organisationsA = Organisations.find().fetch()
    sumOrganisations = 0
    for orga, i in organisationsA
      sumOrganisations += organisationsA[i].mangos
    for users, i in peopleA
      sumPeople += peopleA[i].mangos
    total = sumOrganisations + sumPeople
    return total.toFixed(2)
  averageMangos: ->
    array = Meteor.users.find({verified: true}).fetch()
    total = 0
    for users, i in array
      total += array[i].mangos
    return (total / Meteor.users.find({verified: true}).count()).toFixed(0)
  totalVerifiedPeople: ->
    Meteor.users.find(verified: true).count()
  totalTransactions: ->
    Transactions.find().count()
  totalActions: ->
    Actions.find().count()
  totalMessages: ->
    Messages.find().count()
  totalTime: ->
    array = Actions.find().fetch()
    console.log array
    total = 0
    for time, i in array
      total += array[i].time
      console.log total
    return total
  messages: ->
    Messages.find {},
      sort:
        createdAt: -1
  user: ->
    Meteor.users.findOne @createdBy
  projectName: ->
    Projects.findOne(@childOf).name
  orgaName: ->
    Organisations.findOne(@childOf).name


