Meteor.methods
  #Transfer Amount from Person to Project and back to Person
  addTransaction: (receiver, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          mangos: -amount

      #Add the Transaction amount to Receiver Account
      Meteor.users.update receiver,
        $inc:
          mangos: amount

      #Add the Transaction to the Transaction Collection for History
      Transactions.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        mangos: amount
        sender: Meteor.userId()
        receiver: receiver
        message: message


  #Transfer mangos to project and distribute according to shares to project members
  payProject: (projectId, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          mangos: -amount
      #Get all shares from project
      sharesA = Shares.find({project: projectId}).fetch()
      totalTime = Projects.findOne(projectId).totalTime
      for person, i in sharesA
        #Add the Transaction amount to Receiver Account
        addMangos = sharesA[i].totalTime / totalTime * amount
        receiver = sharesA[i].person
        Meteor.users.update receiver,
          $inc:
            mangos: addMangos

        #Add the Transaction to the Transactions Collection for History
        Transactions.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          mangos: addMangos
          sender: Meteor.userId()
          message: message
          receiver: receiver
          project: projectId


  #Create new Project
  addProjects: (name) ->
    if (Meteor.user().verified)
      projectId =
        Projects.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          banner: "/banner.png"
          name: name
          totalTime: 1
          description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea ta."
      #Insert share into shares collection (temporary workaround)
      Shares.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        person: Meteor.userId()
        totalTime: 1
        project: projectId

  #Add new Action to project
  addAction: (name, min, projectId) ->
    if (Meteor.user().verified)
      Actions.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        name: name
        time: min
        project: projectId

      #Calculate total time spended on this project
      actionsA = Actions.find({project: projectId}).fetch()
      totalTime = 0
      for action, i in actionsA
        totalTime += actionsA[i].time

      #Enter calculated totalTime into project document
      Projects.update projectId,
        $set:
          totalTime: totalTime

      #Find the respective share document for this user and project
      shareId = Shares.findOne '$and': [
        { project: projectId }
        { person: Meteor.userId() }
      ]

      if shareId
        #Find all actions belonging to this share
        actionsA = Actions.find('$and': [
          {project: projectId}
          {createdBy: Meteor.userId() }
        ]).fetch()

        #Calculate totalTime on this share
        console.log actionsA
        totalTime = 0
        for action, i in actionsA
          totalTime += actionsA[i].time

        #Enter totalTime into share document
        Shares.update shareId,
          $set:
            totalTime: totalTime

      #Create new share document
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
    if (Meteor.user().verified)
      currentAge = Meteor.users.findOne(person).years
      if(person != Meteor.userId() and Meteor.users.findOne(person).verifyLevel > 0)
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
        console.log "You can verify yourself or this person"
    else
      console.log "Your are not allowed to verify"

  addMessage: (projectId, message) ->
    console.log projectId + message
    if (Meteor.user().verified)
      Messages.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        message: message
        project: projectId
