$(document).on('turbolinks:load', function(){
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var appendzone = $('.upload-box');
  var images = [];
  var inputs = [];
  var input_area = $('.input_area');
  var preview = $('.preview')
  var preview2 = $('.preview2');
  var append_preview = `<li.image-preview>
                          <div class="image-preview_wapper">
                            <img>
                          </div>
                          <div class="image-preview_btn"> 
                            <a>"編集"</a>
                            <a>"削除"</a>
                          </div>
                        </li>`

  $(document).on('change','input[type="file"].hidden',function(e){
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    reader.onload = function(e){
      append_preview.find('img').attr({
        scr: e.target.result
      })
    }
    reader.readAsDataURL(file);
    images.push(img);
  })

});