$(document).on('turbolinks:load', function() {
  var categoryBox = $('.form-details__form-box__category')

  $(function(){
    // サイズセレクトボックスのオプション表示
    function appendSizeOption(size){
      var html = `<option value="${size.kind}">${size.kind}</option>`;
      return html;
    }

    // サイズ・ブランド入力欄の表示作成
    function appendSizeBox(insertHTML){
      var sizeSelectHtml = '';
      sizeSelectHtml = `<div id="size">
                          <label class="label">サイズ</label>
                          <span>必須</span>
                          <div class='form-select'>
                          <select class= 'select-default' name="product[size]">
                            <option value data-category="---">---</option>
                            ${insertHTML}
                          </select>
                           <i class='fa fa-angle-down icon-angle-down'></i>
                          </div>
                        </div>`
      categoryBox.append(sizeSelectHtml);
    }

    //孫カテゴリー選択後のイベント
    categoryBox.on('change','#grandchild-category',function(){
      var grandchildCategory = $('#grandchild-category option:selected').data('category'); 
      if (grandchildCategory != null){ 
        $.ajax({
          url: 'get_size',
          type: 'GET',
          data: { grandchild_id: grandchildCategory },
          dataType: 'json'
        })
        .done(function(sizes){
          $('#size').remove();
          if (sizes.length != 0) {
            var insertHTML = '';
            sizes.forEach(function(size){
              insertHTML += appendSizeOption(size);
            });
            appendSizeBox(insertHTML);
          }
        })
        .fail(function(){
          alert('サイズ取得に失敗しました');
        })
      } else {
        $('#size').remove();
      }
    });
  });
});


//編集機能
$(document).on('turbolinks:load', function() {
  var categoryBox = $('.form-details__form-box__category')

  $(function(){
    // サイズセレクトボックスのオプション表示
    function appendSizeOption(size){
      var html = `<option value="${size.kind}">${size.kind}</option>`;
      return html;
    }

    // サイズ・ブランド入力欄の表示作成
    function appendSizeBox(insertHTML){
      var sizeSelectHtml = '';
      sizeSelectHtml = `<div id="size">
                          <label class="label">サイズ</label>
                          <span>必須</span>
                          <div class='form-select'>
                          <select class= 'select-default' name="product[size]">
                            <option value data-category="---">---</option>
                            ${insertHTML}
                          </select>
                           <i class='fa fa-angle-down icon-angle-down'></i>
                          </div>
                        </div>`
      categoryBox.append(sizeSelectHtml);
    }

    //孫カテゴリー選択後のイベント
    categoryBox.on('change','#grandchild-category',function(){
      var grandchildCategory = $('#grandchild-category option:selected').data('category'); 
      if (grandchildCategory != null){ 
        $.ajax({
          url: '/products/:id/get_size',
          type: 'GET',
          data: { grandchild_id: grandchildCategory },
          dataType: 'json'
        })
        .done(function(sizes){
          $('#size').remove();
          if (sizes.length != 0) {
            var insertHTML = '';
            sizes.forEach(function(size){
              insertHTML += appendSizeOption(size);
            });
            appendSizeBox(insertHTML);
          }
        })
        .fail(function(){
          alert('サイズ取得に失敗しました');
        })
      } else {
        $('#size').remove();
      }
    });
  });
});