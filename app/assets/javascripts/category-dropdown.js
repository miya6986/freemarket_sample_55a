$(document).on('turbolinks:load', function() {
  $(function(){
    var menu = $(".menu-left__item:first-child")
    var parent = $(".parent__item");
    var child = $(".child__item")
    var parentCategory = $(".parent");
    var childCategory = $(".child")
    var grandchildCategory = $(".grandchild")

    //初期状態では各カテゴリーメニューを非表示にしておく
    parentCategory.hide();
    childCategory.hide();
    grandchildCategory.hide();
    
    //「カテゴリーから探す」 hover時に親カテゴリーメニューを表示
    menu.hover(function(){
      parentCategory.show();
    },
    // hoverが外れたら再度親カテゴリーメニューを非表示にする
    function(){
      parentCategory.hide();
    });

    //親カテゴリー hover時に該当の子カテゴリーメニューを表示する
    $(parent).hover(function(){
      $(this).find(childCategory).show();
    },
    // hoverが外れたら再度子カテゴリーメニューを非表示にする
    function(){
      $(this).find(childCategory).hide();
    });

    //子カテゴリー hover時に該当の孫カテゴリーメニューを表示する
    $(child).hover(function(){
      $(this).find(grandchildCategory).show();
    },
    // hoverが外れたら再度孫カテゴリーメニューを非表示にする
    function(){
      $(this).find(grandchildCategory).hide();
    });
  });
});