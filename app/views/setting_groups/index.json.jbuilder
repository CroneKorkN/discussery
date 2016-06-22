json.array!(@setting_groups) do |setting_group|
  json.extract! setting_group, :id, :name, :setting_group_id
  json.url setting_group_url(setting_group, format: :json)
end
