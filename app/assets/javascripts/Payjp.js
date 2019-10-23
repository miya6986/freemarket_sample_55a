$(document).on('turbolinks:load',function(){
  Payjp.setPublicKey('');
  var form = $("#charge-form"),
      number = form.find('input[name="number"]'),
      cvc = form.find('input[name="cvc"]'),
      exp_month = form.find('select[name="exp_month"]'),
      exp_year = form.find('input[name="exp_year"]');


  $("#charge-form").click(function() {
    form.find("input[type=submit]").prop("disabled", true);

    var card = {
      number: $("").val(),
      cvc: $("").val(),
      exp_month: $("").val(),
      exp_year: $("").val(),
    };

    Payjp.createToken(card, function(status, response) {
      if (response.error){
        form.find('.payment-errors').text(response.error.message);
        form.find('button').prop('disabled', false);
      }   
      else {
        $(".numver").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");
        var token = response.id;

        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      }
    };
  });
});