$(function(){
  // カテゴリーセレクトボックスのオプション
  function appendOption(category) {
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`
    return html;
  }

   // 子カテゴリーの表示
  function appendChildBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = `<div class='form-select' id="child-category">
                        <select class= 'select-default' name="product[category_ids][]">
                            <option value data-category="---">---</option>
                            ${insertHTML}
                          </select>
                          <i class='fa fa-angle-down icon-angle-down'></i>
                       </div>`
    $('.form-details__form-box__category').append(childSelectHtml);
  }

  // 孫カテゴリーの表示
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='form-select' id="grandchild-category">
                              <select class= 'select-default'name="product[category_ids][]">
                               <option value data-category="---">---</option>
                                ${insertHTML}
                               </select>
                              <i class='fa fa-angle-down icon-angle-down'></i>
                            </div>`
    $('.form-details__form-box__category').append(grandchildSelectHtml);
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

  //子カテゴリー選択後のイベント
  $('.form-details__form-box__category').on('change','#child-category',function(){
    var childCategory = $('#child-category option:selected').data('category'); 
    if (childCategory != "---"){ 
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childCategory },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild-category').remove(); 
          $('#size').remove();
          $('#brand').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    } else {
      //子カテゴリーが初期値（---)の場合、孫カテゴリー以下は非表示にする
      $('#grandchild-category').remove(); 
      $('#size').remove();
      $('#brand').remove();
    }
  });
});