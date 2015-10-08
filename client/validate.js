jQuery.validator.addMethod('goodReceiver', function(value, element) {
  if(Meteor.userId() != Session.get("ReceiverId")) {
    return isValid;
  }
}, "You can not send yourself mangos");
