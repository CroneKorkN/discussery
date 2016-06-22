json.array!(@settings) do |setting|
  json.extract! setting, :id, :key, :value, :type, :name, :description, :setting_group_id, :order
  json.url setting_url(setting, format: :json)
end
