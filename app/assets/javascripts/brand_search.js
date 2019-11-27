$(document).on('turbolinks:load',function(){
  var form_input = $(this).parent('form-input');
  var select_wapper = `<div class="input-default select_wapper"></div>`
  function appendList(brand){
    var select_list = `<div class="select_list" data-name="${brand.name}">${brand.name}</div>`
    $(document).find(".select_wapper").append(select_list);
  }
  $("#brand_search").on("keyup",function() {
    var input = $("#brand_search").val();
    $.ajax({
      type: 'GET',
      url: '/brand/search',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(brands) {
      $(".select_wapper").empty();
      if (input.length !== 0){
        if (brands.length !== 0) {
          brands.forEach(function(brand){
            appendList(brand)
          });
        }
        else {
          appendErrMsgToHTML("一致するブランドはありません");
        }
      }
    })
    .fail(function(){
      alert('ブランド検索に失敗しました')
    })
  });
  $(document).on('click', ".select_list", function(){
    brand_name = $(this).attr('data-name')
    $('#brand_search').val(brand_name)
  });
});

