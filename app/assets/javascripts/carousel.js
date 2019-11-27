$(document).on('turbolinks:load', function() {
  $(function(){
    var slider = ".slider"; // スライダー
    var thumbnailItem = ".thumbnail-list .thumbnail-item"; // サムネイル画像アイテム
    var index = $(".slide-item.slick-slide.slick-current").attr("data-slick-index");　//「data-slick-index」(slickで設定したスライドに追加される属性)を取得。
    var thumnailSelected = thumbnailItem+'[data-index="'+index+'"]' //選ばれたサムネイルを属性値「data-index」(slickで設定したスライドに追加される属性)に変更。

    // サムネイル画像アイテムに data-index でindex番号を付与
    $(thumbnailItem).each(function(){
    var index = $(thumbnailItem).index(this);
    $(this).attr("data-index",index);
    });
    
    // スライダー初期化(init)後に発火、カレントのサムネイル画像にクラス「thumbnail-current」を付ける
    $(slider).on('init',function(slick){
    $(thumnailSelected).addClass("thumbnail-current");
    });

    //slickスライダー初期化  
    $(slider).slick({
      arrows: false,
      infinite: false
    });
    //サムネイル画像アイテムをクリックしたときにスライダー切り替え
    // slickGoTo = 指定したindex番号のスライドをカレントにする。
    $(thumbnailItem).on('mouseover',function(){
      var index = $(this).attr("data-index");
      $(slider).slick("slickGoTo",index,false);
    });
    
    //サムネイル画像のカレントを切り替え
    $(slider).on('beforeChange',function(event,slick, currentSlide,nextSlide){
      $(thumbnailItem).each(function(){
        $(this).removeClass("thumbnail-current");
      });
      $(thumbnailItem+'[data-index="'+nextSlide+'"]').addClass("thumbnail-current");
    });
  });
});
