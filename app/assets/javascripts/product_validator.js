$(function(){
  $("#product-form").validate({
    rules: {
      name: {
        required: true
      }
    },
    
    messages: {
      name: {
        required: "入力してください"
      }
    }
  });
})
