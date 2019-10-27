// $(function(){
// $(document).on('turbolinks:road', function(){


  $(document).ready(function(){
    // URLのハッシュ値を取得
    // var urlHash = location.hash;
    // ハッシュ値があればページ内スクロール
    // if(urlHash) {
    //   //スクロールを0に戻す
    //   $('body,html').stop().scrollTop(0);
    //   setTimeout(function () {
    //     //ロード時の処理を待ち、時間差でスクロール実行
    //     scrollToAnker(urlHash) ;
    //   }, 100);
    // }

    $('a[href^="#"]').click(function() {
      var href= $(this).attr("href");
      var hash = href == "#" || href == "" ? 'html' : href;
      scrollToAnker(hash);
      return false;
    });
    
    function scrollToAnker(hash) {
      var target = $(hash);
      var headerHight = 20; // ヘッダーの高さを入れる
      var position = target.offset().top-headerHight;
      console.log('position');
      $('body,html').stop().animate({scrollTop:position}, 250);
    }
  })
// })
// })