$(document).on('turbolinks:load', function() {
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
                          <label>サイズ</label>
                          <span>必須</span>
                          <div class='form-select'>
                          <select class= 'select-default' name="product[size]">
                            <option value data-category="---">---</option>
                            ${insertHTML}
                          </select>
                           <i class='fa fa-angle-down icon-angle-down'></i>
                          </div>
                        </div>
                        <div id="brand">
                          <label>ブランド</label>
                          <span class="optional">任意</span>
                          <div class='form-select'>
                            <input class= 'input-default' name="product[brand_attributes][name]" placeholder="例）シャネル">                   
                          </div>
                        </div>`
      $('.form-details__form-box__category').append(sizeSelectHtml);
    }

    //孫カテゴリー選択後のイベント
    $('.form-details__form-box__category').on('change','#grandchild-category',function(){
      var grandchildCategory = $('#grandchild-category option:selected').data('category'); 
      if (grandchildCategory != "---"){ 
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
        $('#brand').remove();
      }
    });
  });
});