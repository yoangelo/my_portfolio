$(function() {
  var rest =null;
  var cancelFlag = 0;
  $('#rest_search').on("click",function(e) {
    // ページ移行を回避
    e.preventDefault();
    const requestUrl = 'https://api.gnavi.co.jp/RestSearchAPI/v3/';
    const APIkey = $('#apikey').val();
    const name = $('#name').val();

    $.ajax({
      type:"GET",
      url:requestUrl,
      data:{
        keyid: APIkey,
        name: name
      }
    }).done(function(data) {
      if (data != null){
        if(cancelFlag == 0){
          cancelFlag = 1;
          rest = data.rest
          rest.forEach(function(e){
            $('#rest_lists').append(`
              <div class="col-lg-4">
                <div class="card mt-5" style="width: 20rem;">
                  <img src="${e.image_url.shop_image1}" class="card-img-top" size="300x300">
                  <div class="card-body">
                    <h4 class="card-title">${e.name}</h4>
                    <span class="badge badge-success mr-1 mt-1 p-2">
                      ${e.code.prefname}
                    </span>
                    <p class="card-text">
                      <span class="badge badge-warning mr-1 mt-1 p-2">
                        ${e.code.category_name_l[0]}
                      </span>
                    </p>
                    <button type="button" name="button" class="btn btn-primary" id="submit">登録する</button>
                  </div>
                </div>
              </div>
            `)
          })
        }
      }
    }).fail(function() {
      if(cancelFlag == 0){
        cancelFlag = 1;
        $('.result').append(`<li>検索結果は0件でした</li>`);
      }
    });
  });

  $(document).on("click", "#submit", function(e) {
    var elm = $(this);
    var checked_index = $("button").index(elm);
    const post_index = checked_index - 1;
    $.ajax({
      type: "POST",
      url:  "/restaurants",
      data:{
        name: rest[post_index].name,
        address: rest[post_index].address,
        res_id: rest[post_index].id,
        tell: rest[post_index].tel,
        latitude: rest[post_index].latitude,
        longitude: rest[post_index].longitude,
        image_url_1: rest[post_index].image_url.shop_image1,
        image_url_2: rest[post_index].image_url.shop_image2,
        genre: rest[post_index].code.category_name_l[0],
        subgenre: rest[post_index].code.category_name_l[1],
        prefecture: rest[post_index].code.prefname
      }
    }).done(function(data) {
    }).fail(function() {
      alert('エラーが発生しました。詳細はkenose0328@gmail.comへお問い合わせください。');
    });
  });
  $('#name').on("keyup",function(e) {
    $('#rest_lists').empty();
    $('.result').empty();
    cancelFlag = 0;
  });
});
