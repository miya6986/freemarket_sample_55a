
$(document).on('turbolinks:load', function(){  
  // プレビュー機能
  //'change'イベントでは$(this)で要素が取得できないため、 'click'イベントを入れた。
  //これにより$(this)で'input'を取得することができ、inputの親要素である'li'まで辿れる。
  $(document).on('click', '.image_upload', function(){
    $input = $(this);
    $li = $(this).parent('.image-preview');
    $ul = $li.parent('#previews');
    //inputに画像を読み込んだら、"プレビューの追加"と"新しいli追加"処理が動く
    $('.image_upload').on('change', function (e) {
      //inputで選択した画像を読み込む
      var reader = new FileReader();
      //$liに追加するためのプレビュー画面
      var preview = $('<div class="image-preview__wapper"><img class="preview"></div><div class="image-preview_btn"><div class="image-preview_btn_edit">編集</div><div class="image-preview_btn_delete">削除</div></div>'); 
      //次の画像を読み込むためのinput。処理の最後にappendで追加する。 
      var append_input = $(`<li class="image-preview"><input class="image_upload" type="file" id="product_images_attributes_0_name">`)
      

      // プレビューに追加させるために、inputから画像ファイルを読み込む。
      reader.readAsDataURL(e.target.files[0]);
      //画像ファイルが読み込んだら、処理が実行される。 
      reader.onload = function(e){
        //previewをappendで追加する前に、プレビューできるようにinputで選択した画像を<img>に'src'で付与させる
        $(preview).find('.preview').attr('src', e.target.result);
      }
      //inputの画像を付与した,previewを$liに追加。
      $li.append(preview);
      //プレビュー完了後は、inputを非表示にさせる。これによりプレビューだけが残る。
      $input.css('display','none');
      //"ul"に新しい"li(inputボタン)"を追加させる。
      $ul.append(append_input);
    })
  })
  //削除機能
  $(document).on('click','.image-preview_btn_delete',function(){
    $li = $(this).parents('.image-preview');
    //"li"ごと削除して、previewとinputを削除させる。
    $li.remove();
  })
});