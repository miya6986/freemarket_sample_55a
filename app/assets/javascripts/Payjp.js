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
    Payjp.createToken(card, function(status, response) {
      if (response.error){
        alert('トークン作成エラー発生')
      }
      else {
        $(".numver").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");
      }
    }
  });
  

});