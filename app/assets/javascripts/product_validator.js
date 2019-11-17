$(function(){
  $("#product-form").validate({
    errorElement: 'li',
    wrapper: 'ul',
    rules: {
      name: {
        required: true
      },
      description: {
        required: true
      },
      "product[category_ids][]":{
        required: true
      },
      condition: {
        required: true
      },
      postage: {
        required: true
      },
      shipping_method: {
        required: true
      },
      prefecture_id: {
        required: true
      },
      shipping_days: {
        required: true
      },
      price: {
        required: true
      },
    },
    messages: {
      name: {
        required: "入力してください"
      },
      description: {
        required: "入力してください"
      },
      "product[category_ids][]":{
        required: "選択してください"
      },
      condition: {
        required: "選択してください"
      },
      postage: {
        required: "選択してください"
      },
      shipping_method: {
        required: "選択してください"
      },
      prefecture_id: {
        required: "選択してください"
      },
      shipping_days: {
        required: "選択してください"
      },
      shipping_days: {
        required: "選択してください"
      },
      price: {
        required: "300以上9999999以下で入力してください"
      },
    },
    //エラーメッセージの表示位置を指定（ビュー崩れ防止のため）
    errorPlacement: function(error, element) {
      var hasError = element.attr("name");
      if(hasError == "price")
      {
        error.insertAfter(".form-price__form-box__price");	
      } else {
        //デフォルトは要素直下にエラーメッセージを表示する
        error.insertAfter(element);	
      } 
    }
  });
})
