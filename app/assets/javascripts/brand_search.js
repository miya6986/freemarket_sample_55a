$(document).on('turbolinks:load',function(){
  $("#brand").on("keyup",function() {
    var input = $("#brand").val();
    $.ajax({
      type: 'GET',
      url: '/brand/search',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(brands) { 
      $("#brand").empty();
      if (brands.length !== 0) {
        brands.forEach(function(brand){
          appendList(brand);
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

