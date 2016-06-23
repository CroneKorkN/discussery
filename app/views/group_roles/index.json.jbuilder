json.array!(@group_roles) do |group_role|
  json.extract! group_role, :id, :group_id, :role_id, :category_id, :recursive
  json.url group_role_url(group_role, format: :json)
end
