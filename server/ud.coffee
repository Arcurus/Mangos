#Universal Dividend Settings
#Initial reference
udSpark = 1
#Yearly Growth
udGrowth = 0.2
#Linking the Relative Money to a fixed 1 Mango per Day
mangoFactor = 365 #EveryDay 1 Mango will be added to your account -> so every 10 seconds
#Setting the timespeed
interval = 365 * 24 # 1Sec is 1Hour

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
          years: 0.00011416
        $set:
          percent: percent
          mangos: mangos

    else
      Meteor.users.update peopleA[j]._id,
        $set:
          points: 0
          mangos: 0

), 1000
