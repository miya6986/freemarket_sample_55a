
$(document).on('turbolinks:load', function(){
  var image_upload_area = $('.form-image__field');
  var image_upload_area2 = $('.form-image__field2');
  var label = $('.upload-label');
  var previewes = $('#previewes')
  var previewes2 = $('#previewes2');
  var images = [];
  var inputs = [];
  var input_area = $('.input_area');
  var new_image = $(`<input multiple="multiple" name="images[image][]" class="hidden" data-image="0" type="file" id="product_images_attributes_0_name"></input>`)
  
  // プレビュー機能
  $('.image_upload').on('change', function (e) {
    var reader = new FileReader();
    var append_preview = $(`<li class="image-preview">
                              <div class="image-preview_wapper">
                                <img class="preview">
                              </div>
                              <div class="image-preview_btn">
                                <a href="/products/new">編集</a>
                                <a href="/products/new">削除</a>
                              </div>
                              </li>`
                          );                      
    // var file = $(this).prop('files')[0];
    // inputs.push($(this));
    $('#previewes').append(append_preview);
    reader.onload = function(e){
      $('.preview:last-child').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
    // images.push(append_preview);
    console.log('OK2');


    // // 画像が4枚以下のとき
    // if (images.length <= 4) {
    //   $('#previewes').empty();
    //   $.each(images, function(index, image) {
    //     image.data('image', index);
    //     previewes.append(image);
    //   })
    //   image_upload_area.css({
    //     'width': `calc(100% - (20% * ${images.length}))`
    //   })

    //   // 画像が5枚のとき
    // } else if (images.length == 5) {
    //   $("#previewes").empty();
    //   $.each(images, function(index, image) {
    //     image.data("image", index);
    //     previewes.append(image);
    //   });
    //   image_upload_area.css({
    //     display: "none"
    //   });
    //   image_upload_area2.css({
    //     display: "block"
    //   });
    //   previewes2.empty();
    //   // 画像が６枚以上のとき
    // } else if (images.length >= 6) {
    //   image_upload_area.css({
    //     'display': 'none'
    //   })
    //   image_upload_area2.css({
    //     'display': 'block'
    //   })
    //   $.each(images, function(index, image){
    //     image.attr('data-image', index);
    //     previewes2.append(image);
    //     image_upload_area2({
    //       'width': `calc(100% - (135px * ${images.lenght - 5}))`
    //     });
    //   });
    // } else if (images.length == 10){
    //   image_upload_area.css({
    //     'display': 'none'
    //   });
    //   image_upload_area2.css({
    //     'display': 'none'
    //   });
    // }
  })
});