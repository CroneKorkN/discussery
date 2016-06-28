class ACL # Access Controll List
  def initialize(user)
    build_for user unless @acl
    @acl
  end

  def allows?(action, object)
    object_type = object.model_name.route_key.to_sym
    @acl[object_type][object.id] and @acl[object_type][object.id].include?(action.to_sym)
  end
  
  def visible_categories
    @acl[:categories][:visible]if @acl[:categories]
  end

  private
  
  def build_for user
    @acl = {}
    # collect groups
    Recursion.collect_all(user.groups, :memberships).each do |group|
      group.role_scopes.each do |role_scope|
        # category- or group-permission_type?
        scopable_type = role_scope.scopable.model_name.route_key.to_sym
        
        
        affected_scopable_ids = [role_scope.scopable.id]

        # recursive?
        if role_scope.recursive
          affected_scopable_ids << Recursion.collect(role_scope.scopable, scopable_type).pluck(:id)
          affected_scopable_ids.flatten!.uniq!
        end
        
        p affected_scopable_ids
        
        # apply each permission_type to each affected scopable
        role_scope.role.permission_types.each do |permission_type|
          affected_scopable_ids.each do |id|
            add role_scope.scopable.model_name.route_key.to_sym, id, permission_type
          end
        end
      end
    end
    
    user.update acl_cache: @acl
    return @acl
  end
  
  def add type, id, permission_type  
    @acl[type] = {} unless @acl[type]
    @acl[type][id] = [] unless @acl[type][id]
    @acl[type][id] << permission_type.action.to_sym
    if permission_type.action == PermissionType.find(Setting[:visibility_permission_type_id]).action
      @acl[type][:visible] = [] unless @acl[type][:visible]
      @acl[type][:visible] << id
      @acl[type][:visible].uniq!
    end
    return true
  end

  def role_scopes_of user
    # init
    scopable_ids = []
    
    # collect groups
    Recursion.collect_all(user.groups, :groups).each do |group|
      group.role_scopes.each do |role_scope|
        # category- or group-permission_type?
        scopable_type = role_scope.scopable.model_name.route_key.to_sym
        
        # collect affected scopables
        p Recursion.collect(role_scope.scopable, scopable_type).pluck(:id) if role_scope.recursive
        scopable_ids << role_scope.id
        scopable_ids << Recursion.collect(role_scope.scopable, scopable_type).pluck(:id) if role_scope.recursive
      end
    end
    
    # return
    return RoleScope.find(scopable_ids.flatten.uniq)
  end

  def category_id_of object
    if object.class.name == "Category"
      object.id
    else
      object.category.id
    end
  end
end
