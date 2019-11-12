
$(document).on('turbolinks:load', function(){  
  // プレビュー機能
  //'change'イベントでは$(this)で要素が取得できないため、 'click'イベントを入れた。
  //これにより$(this)で'input'を取得することができ、inputの親要素である'li'まで辿れる。
  $(document).on('click', '.image_upload', function(){
    $ul = $('#previews')
    $li = $(this).parents('.image-preview');
    $lis = $ul.find('.image-preview');
    $label = $(this).parents('.upload-label');
    $inputs = $ul.find('.image_upload');
    //inputに画像を読み込んだら、"プレビューの追加"と"新しいli追加"処理が動く
    $('.image_upload').on('change', function (e) {
      //inputで選択した画像を読み込む
      var reader = new FileReader();

      //$liに追加するためのプレビュー画面
      var preview = $('<div class="image-preview__wapper"><img class="preview"></div><div class="image-preview_btn"><div class="image-preview_btn_edit">編集</div><div class="image-preview_btn_delete">削除</div></div>'); 

      //次の画像を読み込むためのinput。処理の最後にappendで追加する。 
      var append_input = $(`<li class="image-preview input"><label class="upload-label"><div class="upload-label__text">ドラッグアンドドロップ<br>またはクリックしてファイルをアップロード<div class="input-area"><input class="hidden image_upload" type="file"></div></div></label></li>`)
      
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
      $label.css('display','none');
      $li.removeClass('input');
      
      $('#previews li').css({
        'width': `114px`
      })
      //"ul"に新しい"li(inputボタン)"を追加させる。
      if($lis.length <= 4 ){
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `calc(100% - (20% * ${$lis.length}))`
        })
      }
      else if($lis.length == 5 ){
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `100%`
        })
      }
      else if($lis.length <= 9 ){
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `calc(100% - (20% * (${$lis.length} - 5 )))`
        })
      }
      
      
      //inputの最後の"data-image"を取得して、input nameの番号を更新させてる。
      $inputs.each( function( num, input ){
        //nameの番号を更新するために、現在の番号を除去
        $(input).removeAttr('name');
        $(input).attr({
          name:"product[images_attributes][" + num + "][name]",
          id:"product_images_attributes_" + num + "_name"
        });
      });
    })
  })
  //削除機能
  $(document).on('click','.image-preview_btn_delete',function(){
    var append_input = $(`<li class="image-preview input"><label class="upload-label"><div class="upload-label__text">ドラッグアンドドロップ<br>またはクリックしてファイルをアップロード<div class="input-area"><input class="hidden image_upload" type="file"></div></div></label></li>`)
    $ul = $('#previews')
    $li = $(this).parents('.image-preview');
    $lis = $ul.find('.image-preview');
    $label = $ul.find('.input')
    //"li"ごと削除して、previewとinputを削除させる。
    $li.remove();
    if($lis.length <= 5 ){
      $label.css({
        'width': `calc(100% - (20% * (${$lis.length} )))`
      })
    }
    else if($lis.length <= 9 ){
      $label.css({
        'width': `calc(100% - (20% * (${$lis.length} - 5 )))`
      })
    }
    else if($lis.length >= 10 ){
      $ul.append(append_input);
      $label.css({
        'width': `calc(100% - (20% * (${$lis.length} - 5 )))`
      })
    }
  })
});

