json.user_name @message.user.name
json.created_at  @message.created_at.to_s(:datetime)
json.body  @message.body
json.image_url @message.image.url