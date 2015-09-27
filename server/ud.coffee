udSpark = 1
udGrowth = 0.2
mangoFactor = 8760
interval = 365 * 24

#Distribute the UD
Meteor.setInterval (->
  sumPeople = Meteor.users.find(verified: true).count()
  peopleA = Meteor.users.find().fetch()
  sumPoints = 0
  for allPeople, i in peopleA
    sumPoints += peopleA[i].points
  if sumPoints is 0
    ud = (udSpark / sumPeople) / interval
  else
    ud = (udSpark + (udGrowth * sumPoints / sumPeople)) / interval
  for person, j in peopleA
    if peopleA[j].verified is true
      mangos = peopleA[j].points * mangoFactor / ud / interval
      percent = peopleA[j].points * 100 / sumPoints
      Meteor.users.update peopleA[j]._id,
        $inc:
          points: ud
        $set:
          percent: percent
          mangos: mangos

    else
      Meteor.users.update peopleA[j]._id,
        $set:
          points: 0
          mangos: 0
          verified: true

), 1000
