$(function() {
  // ユーザーを検索
  function showUser(user){
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
                </div>`
    return html;
  }
  $("#user-search-field").on("keyup", function() {
    var input = $("#user-search-field").val();
    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(users) {
      $('#user-search-result').empty();
      if (users.length !== 0) {
        users.forEach(function(user){
          var html = showUser(user);
          $('#user-search-result').append(html);
        });
      } else {
        var html = `<div class="chat-group-user clearfix">
                      <p class="chat-group-user__name">ユーザーが見つかりません</p>
                    </div>`
        $('#user-search-result').append(html);
      }
    })
    .fail(function() {
      alert("ユーザー検索に失敗しました");
    })
  });

  // 選択したユーザーを追加
  $('.chat-group-form__field--right').on('click', '.chat-group-user__btn--add', function(){
    var user = $(this).data();
    $(this).parent().remove();
    var html = `<div class='chat-group-user clearfix js-chat-member'>
                    <input name='group[user_ids][]' type='hidden' value='${user.userId}'>
                    <p class='chat-group-user__name'>${user.userName}</p>
                    <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
                </div>`
    $('.js-add-user').append(html)
  });

  // 選択したユーザーを削除
  $('.js-add-user').on('click', '.chat-group-user__btn--remove', function(){
    $(this).parent().remove();
  });
});