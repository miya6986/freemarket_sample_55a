$(document).on('turbolinks:load',function(){
  /*公開キーのセット*/ 
  Payjp.setPublicKey('pk_test_62c91b0f0f85efaf575ea6b5');
  var form = $(".form"),
      number = form.find('input[name="card_number"]'),
      cvc = form.find('input[name="cvc"]'),
      exp_month = form.find('select[name="exp_month"]'),
      exp_year = form.find('select[name="exp_year"]');


  $("#charge-form").click(function() {
    /* submitの送信を止めて、Jqueryで指定の処理をさせる。*/
    form.find("input[type=submit]").prop("disabled", true);
    /* Payjpに送るためのトークン情報を入力欄から取得していく*/
    var card = {
      number: $("#card_number").val(),
      cvc: $("#cvc").val(),
      exp_month: $("#exp_month").val(),
      exp_year: $("#exp_year").val(),
    };
    
    /*取得した情報からPayjp指定の処理でトークンを生成する*/
    Payjp.createToken(card, function(status, response) {
      /*エラーがあった場合、下記の処理が動く*/
      if (response.error){
        form.find('.payment-errors').text(response.error.message);
        form.find('button').prop('disabled', false);
      }   
      /*エラーがない場合、処理が動く*/
      else {
        /* Payjp用のトークン作成後は、dbには必要がないためクレジットカード情報は除去*/
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        var token = response.id;
        /* 隠しinputを入れる。*/
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        /*止めていたsubmitを動かして、Payjp,dbに保存する。*/
        form.get(0).submit();
      };
    });
  });
});