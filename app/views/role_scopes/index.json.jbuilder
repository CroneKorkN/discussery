json.array!(@role_scopes) do |role_scope|
  json.extract! role_scope, :id, :group_id, :role_id, :scopable_id, :scopable_type
  json.url role_scope_url(role_scope, format: :json)
end
