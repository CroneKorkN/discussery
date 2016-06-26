json.array!(@last_accesses) do |last_access|
  json.extract! last_access, :id, :user_id, :topic_id, :time
  json.url last_access_url(last_access, format: :json)
end
