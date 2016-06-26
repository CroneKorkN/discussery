class ACL # Access Controll List
  def initialize(user)
    build_for user unless @acl
    @acl
  end

  def allows?(action, scopable)
    scopable_type = scopable.model_name.route_key.to_sym
    @acl[scopable_type][scopable.id] and @acl[scopable_type][scopable.id].include?(action.to_sym)
  end
  
  def visible_categories
    @acl[:visible]
  end

  private

  def all_memberships user
    Recursion.collect_all(user.groups, :groups)
  end
  
  def build_for user
    @acl = {
      categories: {},
      groups: {},
      visible: []
    }
    
    scopable_ids = []
    
    # collect groups
    Recursion.collect_all(user.groups, :groups).each do |group|
      group.role_scopes.each do |role_scope|
        # category- or group-permission?
        scopable_type = role_scope.scopable.model_name.route_key.to_sym
        
        # collect affected scopables
        scopable_ids << [role_scope.scopable.id]
        scopable_ids << Recursion.collect(role_scope.scopable, scopable_type).pluck(:id) if role_scope.recursive
        
        # insert permissions into acl
        scopable_ids.flatten.uniq.each do |scopable_id|
          # scopable-key exists?
          @acl[scopable_type][scopable_id] = [] unless @acl[scopable_type][scopable_id]
          # insert permissions
          role_scope.role.permissions.each do |permission|
            @acl[scopable_type][scopable_id] << permission.action.to_sym
            @acl[:visible] << scopable_id if permission.action.to_sym == :read_category
          end
        end
      end
    end
    
    @acl[:visible].uniq!
    user.update acl_cache: @acl
    return @acl
  end

  def category_id_of object
    if object.class.name == "Category"
      object.id
    else
      object.category.id
    end
  end
end
