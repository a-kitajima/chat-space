$(function() {
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
})