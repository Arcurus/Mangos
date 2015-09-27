Accounts.onCreateUser(function(options, user) {
  if (options.profile) {
    options.profile.picture = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large";
    user.profile = options.profile;
  }
  user.points = 0;
  user.percent = 0;
  user.mangos = 0;
  user.verified = false;
  return user;
});

Houston.add_collection(Meteor.users);
Houston.add_collection(Houston._admins);
