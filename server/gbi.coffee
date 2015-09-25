totalMoney = 100000000
demurrageFee = 0.1
gbiPerSecond = 365 * 24 * 60 * 60

#Distribute the BasicIncome
Meteor.setInterval (->
  verifiedPeople = Meteor.users.find({verified: true}).count()
  peopleA = Meteor.users.find().fetch()
  for person, i in peopleA
    gbiTake = peopleA[i].account * demurrageFee / gbiPerSecond
    if peopleA[i].verified is true
      gbiAdd = totalMoney * demurrageFee / gbiPerSecond / verifiedPeople
      Meteor.users.update peopleA[i]._id,
        $inc:
          account: gbiAdd - gbiTake
        $set:
          gbi: gbiAdd - gbiTake
    else
      Meteor.users.update peopleA[i]._id,
        $inc:
          account: - gbiTake
        $set:
          gbi: - gbiTake

), 1000
