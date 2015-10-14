Meteor.methods
  #Transfer Amount from Person to Project and back to Person
  addTransaction: (receiver, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Calculate the respective Points
      points = amount * Meteor.user().points / Meteor.user().mangos
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          points: -points

      #Add the Transaction amount to Receiver Account
      Meteor.users.update receiver,
        $inc:
          points: points

      #Add the Transaction to the Transaction Collection for History
      Transactions.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        amount: amount
        points: points
        sender: Meteor.userId()
        receiver: receiver
        message: message

  payProject: (projectId, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Calculate the respective Points
      points = amount * Meteor.user().points / Meteor.user().mangos
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          points: -points

      sharesA = Shares.find({project: projectId}).fetch()
      totalTime = Projects.findOne(projectId).totalTime
      for person, i in sharesA
        #Add the Transaction amount to Receiver Account
        addPoints = sharesA[i].totalTime / totalTime * points
        addMangos = sharesA[i].totalTime / totalTime * amount
        receiver = sharesA[i].person
        Meteor.users.update sharesA[i].person,
          $inc:
            points: addPoints

        #Add the Transaction to the Transactions Collection for History
        Transactions.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          mangos: addMangos
          points: addPoints
          sender: Meteor.userId()
          message: message
          receiver: receiver
          project: projectId


  #Create new Project
  addProjects: (name) ->
    Projects.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      name: name
      totalTime: 0

  addAction: (name, min, projectId) ->
    Actions.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      name: name
      time: min
      project: projectId

    Projects.update projectId,
      $inc:
        totalTime: min

    shareId = Shares.findOne '$and': [
      { project: projectId }
      { person: Meteor.userId() }
    ]

    if shareId
      Shares.update shareId,
        $inc:
          totalTime: min
    else
      shareId =
        Shares.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          person: Meteor.userId()
          totalTime: min
          project: projectId

  #Verify a Person
  verifyPerson: (person) ->
    currentAge = Meteor.users.findOne(person).years
    if person != Meteor.userId()
      Meteor.users.update person,
        $set:
          verifiedAt: currentAge
       #Add the Verification to the Verifications Collection
      Verifications.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        verifiedPerson: person
        verifiedAt: currentAge
    else
      console.log "You can not verify yourself"


