$(function(){
  // カテゴリーセレクトボックスのオプション
  function appendOption(category) {
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`
    return html;
  }

   // 子カテゴリーの表示
  function appendChildBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = `<div class='form-select' id="child-category">
                        <select class= 'select-default' name="category_id">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          </select>
                          <i class='fa fa-angle-down icon-angle-down'></i>
                       </div>`
    $('.form-details__form-box__category').append(childSelectHtml);
  }

  // 親カテゴリー選択後のイベント
  $("#parent-category").on("change", function(){
    var parentCategory = document.getElementById("parent-category").value;
    if(parentCategory !== "") {
        $.ajax ({
        url: '/products/get_category_children',
        type: "GET",
        data: {
          parent_id: parentCategory
        },
        dataType: 'json'
      })
      .done(function(children) {
        $('#child-category').remove();
        $('#grandchild-category').remove();
        $('#size').remove();
        $('#brand').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    } else {
      //親カテゴリーが初期値（---)の場合、子カテゴリー以下は非表示にする
      $('#child-category').remove(); 
      $('#grandchild-category').remove();
    }
  });
});