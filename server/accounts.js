Accounts.onCreateUser(function(options, user) {
  if (options.profile) {
    options.profile.picture = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large";
    user.profile = options.profile;
    user.username = user.services.facebook.first_name + " " + user.services.facebook.last_name;
    user.verifyLevel = 1
  }
  else {
    user.verifyLevel = 0
  }
  user.years = 0;
  user.points = 0;
  user.percent = 0;
  user.mangos = 0;
  user.verified = false;
  user.verifiedAt = -5;
  return user;
});

Houston.add_collection(Meteor.users);
Houston.add_collection(Houston._admins);

