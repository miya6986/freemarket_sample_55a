$(document).on('turbolinks:load',function(){ 
  $('.top-slider').slick({
    autoplay: true,
    autoplaySpeed: 4000,
    speed: 800,
    dots:     true,
    // dotsClass: 'top-dot-class',
    infinite: true,
    prevArrow:'<i class="fa fa-angle-left arrow arrow-left"></i>',
    nextArrow:'<i class="fa fa-angle-right arrow arrow-right"></i>',
  });
});