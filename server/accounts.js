Accounts.onCreateUser(function(options, user) {
  if (options.profile) {
    options.profile.picture = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large";
    user.profile = options.profile;
    user.verified = true;
  }
  else {
    user.verified = false;
  }
  user.years = 1;
  user.points = 0;
  user.percent = 0;
  user.mangos = 0;
  return user;
});

Houston.add_collection(Meteor.users);
Houston.add_collection(Houston._admins);
