json.array!(@topics) do |topic|
  json.extract! topic, :id, :name, :category_id, :user_id
  json.url topic_url(topic, format: :json)
end
