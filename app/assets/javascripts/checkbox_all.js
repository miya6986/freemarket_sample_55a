$(function() {
  $('.all').on("click",function(){
    $('.list').prop("checked", $(this).prop("checked"));
  });
  $('.all-postage').on("click",function(){
    $('.list-postage').prop("checked", $(this).prop("checked"));
  });
  $('.all-status').on("click",function(){
    $('.list-status').prop("checked", $(this).prop("checked"));
  });
});