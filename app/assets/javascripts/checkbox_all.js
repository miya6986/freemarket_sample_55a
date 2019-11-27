$(function() {
  $('.all').on("click",function(){
    $('.list').prop("checked", $(this).prop("checked"));
  });
  $('.all-postage').on("click",function(){
    $('.list-postage').prop("checked", $(this).prop("checked"));
  });
});
// $(function() {
//   $('.all-postage').on("click",function(){
//     $('.list-postage').prop("checked", $(this).prop("checked"));
//   });
// });