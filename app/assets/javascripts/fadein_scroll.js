$(function(){
  $(document).on('turbolinks:load',function(){
    function scroll_fadein(){
      $('.fadein').each(function(){
        var elemPos = $(this).offset().top;
        var scroll = $(window).scrollTop();
        var windowHeight = $(window).height();
        if (scroll > elemPos - windowHeight + 100){
          $(this).addClass('scrollin');
        }
      });
    }
    $(function(){
      $(window).scroll(function(){
        scroll_fadein();
      });
      scroll_fadein();
    });
  });
});