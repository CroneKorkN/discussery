json.array!(@users) do |user|
  json.extract! user, :id, :name, :mail, :password, :password_digest
  json.url user_url(user, format: :json)
end
