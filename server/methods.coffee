Meteor.methods
  #Transfer Amount from Person to Bundle and back to Person
  addTransaction: (receiver, amount) ->
    #Remove the Transaction amount from the Senders Account
    Meteor.users.update Meteor.userId(),
      $inc:
        account: -amount

    #Add the Transaction amount to Receiver Account
    Meteor.users.update receiver,
      $inc:
        account: amount

    #Add the Transaction to the Transaction Collection for History
    Transactions.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      amount: amount
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

