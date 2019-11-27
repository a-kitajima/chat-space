json.array! @users do |user|
  unless user.id == current_user.id
    json.id user.id
    json.name user.name
  end
end