Accounts.onCreateUser(function(options, user) {
  if (options.profile) {
    options.profile.picture = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large";
    user.profile = options.profile;
  }
  user.account = 0;
  user.verified = false;
  user.gbi = 0;
  user.name = "Anonymous";
  return user;
});

Houston.add_collection(Meteor.users);
Houston.add_collection(Houston._admins);
