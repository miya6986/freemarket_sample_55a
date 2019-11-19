$(document).on('turbolinks:load', function() {
  $(function(){
    var menu = $(".menu-left__item:first-child")
    var category = $("#category");

    //初期状態ではカテゴリーメニュー非表示
    category.hide();
    // 「カテゴリーから探す」 hover時にメニューを表示
    menu.hover(function(){
      category.show();
    },
    // hoverが外れたら再度メニューを非表示にする
    function(){
      category.hide();
    });
  });
});