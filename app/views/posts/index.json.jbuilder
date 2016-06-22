json.array!(@posts) do |post|
  json.extract! post, :id, :content, :content_searchable, :topic_id, :user_id, :date
  json.url post_url(post, format: :json)
end
