Meteor.methods
  #Transfer Amount from Person to Project and back to Person
  addTransaction: (receiver, amount, message) ->
    if Meteor.user().verified
      #Calculate the respective Points
      amountPoints = amount * Meteor.user().points / Meteor.user().mangos
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
        mangos: amount
        points: amountPoints
        from: Meteor.userId()
        message: message
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

  #Verify a Person
  verifyPerson: (person) ->
    currentAge = Meteor.users.findOne(person).years
    if person != Meteor.userId()
      Meteor.users.update person,
        $set:
          verifiedAt: currentAge
       #Add the Verification to the Verification Collection for History
      Verifications.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        verifiedPerson: person
        verifiedAt: currentAge
    else
      console.log "You can not verify yourself"


