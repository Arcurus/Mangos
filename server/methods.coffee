Meteor.methods
  #Transfer Amount from Person to Project and back to Person
  addTransaction: (receiver, amountPoints) ->
    #Remove the Transaction amount from the Senders Account
    Meteor.users.update Meteor.userId(),
      $inc:
        points: -amountPoints

    #Add the Transaction amount to Receiver Account
    Meteor.users.update receiver,
      $inc:
        points: amountPoints

    #Add the Transaction to the Transaction Collection for History
    Transactions.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      points: amountPoints
      from: Meteor.userId()
      receiver: receiver

  #Create new Project
  addProjects: (name) ->
    Projects.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      name: name
      account: 0
      shares: [
        person: Meteor.userId()
        percent: 100
      ]

