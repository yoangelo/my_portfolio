$(function() {
  var rest =null;
  var cancelFlag = 0;
  $('#rest_search').on("click",function(e) {
    // ページ移行を回避
    e.preventDefault();
    const requestUrl = 'https://api.gnavi.co.jp/RestSearchAPI/v3/';
    const APIkey = $('#apikey').val();
    const name = $('#name').val();
    console.log(name);

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
            // $('#rest_lists').append(`<li id="rest_list"><input type="radio" name="rest_name">${e.name}</li>`)
            $('#rest_lists').append(`<li id="rest_list"><input type="radio" name="rest_name">${e.name}<img src="${e.image_url.shop_image1}"><img src="${e.image_url.shop_image2}"></li>`)
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

  $('#submit').on("click",function(e) {
    const checked_index = $("input:radio").toArray().findIndex(e => e.checked);
    $.ajax({
      type: "POST",
      url:  "/restaurants",
      data:{
        name: rest[checked_index].name,
        address: rest[checked_index].address,
        res_id: rest[checked_index].id,
        tell: rest[checked_index].tel,
        latitude: rest[checked_index].latitude,
        longitude: rest[checked_index].longitude,
        image_url_1: rest[checked_index].image_url.shop_image1,
        image_url_2: rest[checked_index].image_url.shop_image2
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
