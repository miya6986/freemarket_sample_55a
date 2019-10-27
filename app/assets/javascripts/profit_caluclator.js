$(function(){
  function calculateProfit(price) {
    var charge = Math.floor(price / 10)
    var profit = (price - charge);
    $(".form-price__form-box__charge__right").text("¥" + charge.toLocaleString());
    $(".form-price__form-box__profit__right").text("¥" + profit.toLocaleString());
  }
  
  function priceNone() {
    $(".form-price__form-box__charge__right").text("-");
    $(".form-price__form-box__profit__right").text("-");
  }
  
  $("#price").on('keyup',function(e){
    e.preventDefault();
    var price = document.getElementById("price").value;
    if(300<= price && price <= 9999999) {
      calculateProfit(price);
    } else {
      priceNone();
    }
  })
});