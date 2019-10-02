$(function(){
  $(document).on('turbolinks:load', function() {
    $('.tab1').click(function(){
      var tab = $('.tab1')
      var index = tab.index(this);
      tab.removeClass('active');
      $(this).addClass('active');
      $('.lists1 ul').removeClass('show').eq(index).addClass('show')
    })

    $('.tab2').click(function(){
      var tab = $('.tab2')
      var index = tab.index(this);
      tab.removeClass('active');
      $(this).addClass('active');
      $('.lists2 ul').removeClass('show').eq(index).addClass('show')
    })
    // function tabswitch (){
    //   var tab = $(this);
    //   // 何番目のtabか？
    //   var tab_index = tab.index(this);
    //   //何番目のmypage_tabsか？
    //   var tabs_index = $(this).closest().index(this);
    //   //tabのactiveを除去して、選んだtabにactibeを付与

    //   tab.parent().children().removeClass('active')
    //   $(this).addClass('active');
    //   $('.mypage_content').eq(tabs_index).$('ul').removeClass('show').eq(tab_index).addClass('show')
    // }
    // //   $('.mypage_content ul').removeClass('show').eq(tab_index).addClass('show')
    // // }
    // $('.mypage_tab').click(tabswitch);
  });
});
