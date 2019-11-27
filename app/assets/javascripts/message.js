$(function() {
  // 非同期メッセージ送信
  function buildHTML(message){
    var message_image_tag = (message.image_url)?`<img src="${message.image_url}">`:"";
    var html = `<div class="message">
                  <div class="message__upper-info">
                    <p class="message__upper-info__talker">${message.user_name}</p>
                    <p class="message__upper-info__date">${message.created_at}</p>
                  </div>
                  <p class="message__text">${message.body}</p>
                  ${message_image_tag}
                </div>`
    return html;
  }
  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.messages').append(html);
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
      $('#new_message')[0].reset();
      $('.submit-btn').prop('disabled', false);
    })
    .fail(function() {
      alert('メッセージ送信に失敗しました');
      $('.submit-btn').prop('disabled', false);
    })
  })

  last_message_id = $('.message:last').data();
  console.log(last_message_id.messageId)
  console.log(location.href)
  var url = location.href.match(/\/groups\/[0-9]{1,}\/messages/);
  console.log(url[0])
  url[0] = url[0].replace(/messages/g, 'api/messages');
  console.log(url[0])
  // 自動更新
  // var reloadMessages = function() {
  //   last_message_id = $('.message:last').data();
  //   console.log(last_message_id)
  //   console.log(location.href)
  //   $.ajax({
  //     //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
  //     url: ※※※,
  //     type: 'get',
  //     dataType: 'json',
  //     data: {id: last_message_id}
  //   })
  //   .done(function(messages) {
  //     console.log('success');
  //   })
  //   .fail(function() {
  //     console.log('error');
  //   });
  // };
})