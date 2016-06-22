json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :post_id, :medium_id
  json.url attachment_url(attachment, format: :json)
end
