Meteor.methods
  #Transfer Amount from Person to Project and back to Person
  addTransaction: (receiver, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
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

  payProject: (projectId, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Calculate the respective Points
      amountPoints = amount * Meteor.user().points / Meteor.user().mangos
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          points: -amountPoints

      sharesA = Shares.find({project: projectId}).fetch()
      totalMin = Projects.findOne(projectId).totalMin
      for person, i in sharesA
        #Add the Transaction amount to Receiver Account
        addPoints = sharesA[i].min / totalMin * amountPoints
        addMangos = sharesA[i].min / totalMin * amount
        console.log addMangos
        receiver = sharesA[i].createdBy
        Meteor.users.update sharesA[i].createdBy,
          $inc:
            points: addPoints

        #Add the Transaction to the Transactions Collection for History
        Transactions.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          mangos: addMangos
          points: addPoints
          from: Meteor.userId()
          message: message
          receiver: receiver
          project: projectId


  #Create new Project
  addProjects: (name) ->
    Projects.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      name: name
      totalMin: 0
      actions: []

  addAction: (name, min, projectId) ->
    Actions.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      name: name
      min: min
      project: projectId

    Projects.update projectId,
      $inc:
        totalMin: min

    shareId = Shares.findOne '$and': [
      { project: projectId }
      { createdBy: Meteor.userId() }
    ]

    if shareId
      Shares.update shareId,
        $inc:
          min: min
    else
      shareId =
        Shares.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          min: min
          project: projectId

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


