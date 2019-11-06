$(document).on('turbolinks:load', function() {
  $(function(){
    // サイズセレクトボックスのオプション表示
    function appendSizeOption(size){
      var html = `<option value="${size.size}">${size.size}</option>`;
      return html;
    }

    // サイズ・ブランド入力欄の表示作成
    function appendSizeBox(insertHTML){

    }

    //孫カテゴリー選択後のイベント
    $().on('change','',function(){

    });
  });
});