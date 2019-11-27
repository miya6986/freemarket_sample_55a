$(document).on('turbolinks:load',function(){
  var form_input = $(this).parent('form-input');
  var select_wapper = `<div class="input-default select_wapper"></div>`
  function appendList(brand){
    var select_list = `<div class="select_list">${brand.name}</div>`
    $(document).find(".select_wapper").append(select_list);
  }
  $("#brand").on("keyup",function() {
    var input = $("#brand").val();
    $.ajax({
      type: 'GET',
      url: '/brand/search',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(brands) {
      $(".select_wapper").empty();
      if (brands.length !== 0) {
        brands.forEach(function(brand){
          appendList(brand)
        });
      }
      else {
        appendErrMsgToHTML("一致するブランドはありません");
      }
    })
    .fail(function(){
      alert('ブランド検索に失敗しました')
    })
  });
});

