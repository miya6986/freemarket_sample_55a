// 価格の範囲が選択された時、MINとMAXを入力する
$(function() {
  $('.search-content__price__select--form').change(function() {
    var price_range = $(this).children('option:selected').val().split('~', 2);
    var min_price = price_range[0];
    var max_price = price_range[1];
    $('.search-content__price__details__min').val(min_price);
    $('.search-content__price__details__max').val(max_price);
  })
})