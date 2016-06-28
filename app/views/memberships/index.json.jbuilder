json.array!(@memberships) do |membership|
  json.extract! membership, :id, :member, :group_id
  json.url membership_url(membership, format: :json)
end
