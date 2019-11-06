$(document).on('turbolinks:load', function() {
  $(function(){
    var chargeBox = $(".form-price__form-box__charge__right");
    var profitBox = $(".form-price__form-box__profit__right")

    function calculateProfit(price) {
      var charge = Math.floor(price / 10)
      var profit = price - charge;
      chargeBox.text("¥" + charge.toLocaleString());
      profitBox.text("¥" + profit.toLocaleString());
    }
    
    function priceNone() {
      chargeBox.text("-");
      profitBox.text("-");
    }
    
    $("#price").on('keyup',function(){
      var price = document.getElementById("price").value;
      if(300<= price && price <= 9999999) {
        calculateProfit(price);
      } else {
        priceNone();
      }
    })
  });
});