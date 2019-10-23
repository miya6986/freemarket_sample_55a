$(document).on('turbolinks:load',function(){
  var form = $("");
  Payjp.setPublicKey('');
  $(document).on("click", "#submit-button", function(e) {

    e.preventDefault();
  })
  

});