json.array!(@group_groups) do |group_group|
  json.extract! group_group, :id, :group_id, :member_group_id
  json.url group_group_url(group_group, format: :json)
end
