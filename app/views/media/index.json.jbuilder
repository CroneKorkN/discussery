json.array!(@media) do |medium|
  json.extract! medium, :id, :type, :location
  json.url medium_url(medium, format: :json)
end
