jQuery.validator.addMethod('unique', function(name) {
  if(name != Session.get("ReceiverId")) {
    return isValid;
  }
});
