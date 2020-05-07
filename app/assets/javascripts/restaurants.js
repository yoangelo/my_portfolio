$(document).on('turbolinks:load', function() {
  var rest =null;
  var cancelFlag = 0;
  $('#search').on("click",function(e) {
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
            $('#rest_lists').append(`<li id="rest_list"><input type="radio" name="rest_name">${e.name}</li>`)
          })
        }
      } else{
        $('.result').append(`<li>検索結果は0件でした</li>`);
      }
    }).fail(function() {
      alert('情報の取得に失敗しました');
    });
  });

  $('#submit').on("click",function(e) {
    console.log(rest);
    const checked_index = $("input:radio").toArray().findIndex(e => e.checked);
    console.log(rest[checked_index]);
    console.log(rest[checked_index].name);
    console.log(rest[checked_index].address);
    console.log(rest[checked_index].id);
    console.log(rest[checked_index].tel);
    $.ajax({
      type: "GET",
      url:  "/reviews/new",
      data:{
        name: rest[checked_index].name,
        address: rest[checked_index].address,
        res_id: rest[checked_index].id,
        tell: rest[checked_index].tel
      }
    });
  });
  $('#name').on("keyup",function(e) {
    $('#rest_lists').empty();
    cancelFlag = 0;
  });
});
