#Universal Dividend Settings
interval = (24 * 60) # 1Sec is 1min or 1min is 1h or 24min is 1day or 12h is 1month or 3.5 days is 1 year or 35days ~10 years
dailyUD = 24
addUD = (dailyUD / interval)
demurrageFee = 0.2
dailyRotting = (demurrageFee / 365)

#Distribute the UD
Meteor.setInterval (->
  sumPeople = Meteor.users.find(verified: true).count()
  peopleA = Meteor.users.find().fetch()
  totalMangos = 0
  for person, i in peopleA
    totalMangos += peopleA[i].mangos

  for person, j in peopleA
    timeSinceVerified = peopleA[j].years - peopleA[j].verifiedAt
    if peopleA[j].verified is true
      takeUD = peopleA[j].mangos * dailyRotting / interval
      percent = peopleA[j].mangos * 100 / totalMangos

      Meteor.users.update peopleA[j]._id,
        $inc:
          mangos: addUD - takeUD
          years: 0.0000019
        $set:
          percent: percent

      if timeSinceVerified > 5
        Meteor.users.update peopleA[j]._id,
          $set:
            verified: false

    else
      Meteor.users.update peopleA[j]._id,
        $set:
          mangos: 0
          percent: 0
        $inc:
          years: 0.0000019

      if timeSinceVerified < 5
        Meteor.users.update peopleA[j]._id,
          $set:
            verified: true

), 1000
