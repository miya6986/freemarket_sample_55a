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
  });
});
