$(function(){
  $(document).on('turbolinks:load',function(){
    $(document).ready(function(){
      $('.nav__item').click(function() {
        var href= $(this).attr("href");
        var hash = href == "#" || href == "" ? 'html' : href;
        scrollToAnker(hash);
        return false;
      });
      
      function scrollToAnker(hash) {
        var target = $(hash);
        var headerHight = 20; // ヘッダーの高さを入れる
        var position = target.offset().top - headerHight;
        $('body,html').stop().animate({scrollTop:position}, 250);
      }
    })
  })
})