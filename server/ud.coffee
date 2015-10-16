#Universal Dividend Settings
#Initial reference
udSpark = 100
#Yearly Growth & Dividend
udGrowth = 0.2
#Linking the Relative Money to a fixed 10 Mangos per Day
mangoFactor = (365 * 24) #EveryDay 10 Mangos will be added to your account
#Setting the timespeed
interval = (365 * 24 * 60) # 1Sec is 1min or 1min is 1h or 24min is 1day or 12h is 1month or 3.5 days is 1 year or 35days ~10 years

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
    timeSinceVerified = peopleA[j].years - peopleA[j].verifiedAt
    if peopleA[j].verified is true
      mangos = peopleA[j].points * mangoFactor / ud / interval
      percent = peopleA[j].points * 100 / sumPoints

      Meteor.users.update peopleA[j]._id,
        $inc:
          points: ud
          years: 0.0000019
        $set:
          percent: percent
          mangos: mangos

      if timeSinceVerified > 5
        Meteor.users.update peopleA[j]._id,
          $set:
            verified: false

    else
      Meteor.users.update peopleA[j]._id,
        $set:
          points: 0
          mangos: 0
          percent: 0
        $inc:
          years: 0.0000019

      if timeSinceVerified < 5
        Meteor.users.update peopleA[j]._id,
          $set:
            verified: true

), 1000
