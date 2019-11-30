$(function(){
  $("#product-form-edit").validate({
    ignore: [],
    errorElement: 'li',
    wrapper: 'ul',
    rules: {
      "product[name]": {
        required: true
      },
      "product[description]": {
        required: true
      },
      "product[category_ids][]":{
        required: true
      },
      "product[size]": {
        required: true
      },
      "product[condition]": {
        required: true
      },
      "product[condition]": {
        required: true
      },
      "product[postage]": {
        required: true
      },
      "product[shipping_method]": {
        required: true
      },
      "product[prefecture_id]": {
        required: true
      },
      "product[shipping_days]": {
        required: true
      },
      "product[price]": {
        required: true,
        digits: true,
        min: 300,
        max: 9999999
      }
    },
    messages: {
      "product[name]": {
        required: "入力してください"
      },
      "product[description]": {
        required: "入力してください"
      },
      "product[category_ids][]":{
        required: "選択してください"
      },
      "product[size]": {
        required: "選択してください"
      },
      "product[condition]": {
        required: "選択してください"
      },
      "product[postage]": {
        required: "選択してください"
      },
      "product[shipping_method]": {
        required: "選択してください"
      },
      "product[shipping_days]": {
        required: "選択してください"
      },
      "product[prefecture_id]": {
        required: "選択してください"
      },
      "product[shipping_days]": {
        required: "選択してください"
      },
      "product[price]": {
        required: "選択してください"
      },
      "product[price]": {
        required: "300以上9999999以下で入力してください",
        digits: "300以上9999999以下で入力してください",
        min: "300以上9999999以下で入力してください",
        max: "300以上9999999以下で入力してください"
      }
    },
    //エラーメッセージの表示位置を指定（ビュー崩れ防止のため）
    errorPlacement: function(error, element) {
      var hasError = element.attr("name");
      if(hasError == "product[price]")
      {
        error.insertAfter(".form-price__form-box__price");	
      } 
      else {
        //デフォルトは要素直下にエラーメッセージを表示する
        error.insertAfter(element);	
      } 
    }
  });
})
