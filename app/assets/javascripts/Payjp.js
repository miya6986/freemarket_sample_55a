$(document).on('turbolinks:load',function(){
  var form = $("");
  Payjp.setPublicKey('');
  $(document).on("click", "#submit-button", function(e) {

    e.preventDefault();

    var card = {
      number: $("").val();
      cvc: $("").val();
      exp_month: $("").val();
      exp_year: $("").val();
    };
  });
  

});