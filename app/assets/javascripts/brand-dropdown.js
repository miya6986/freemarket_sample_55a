$(document).on('turbolinks:load', function() {
  $(function(){
    var brandMenu = $(".menu-left__item:last-child")
    var brand = $(".brand")

    //初期状態ではブランドメニューを非表示にしておく
    brand.hide();

    //「ブランドから探す」 hover時にブランドメニューを表示
    brandMenu.hover(function(){
      brand.show();
    },
    // hoverが外れたら再度ブランドメニューを非表示にする
    function(){
      brand.hide();
    });
  });
});