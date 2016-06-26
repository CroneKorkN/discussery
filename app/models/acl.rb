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
    @acl[:categories][:visible]
  end

  private
  
  def build_for user
    @acl = {}
    
    scopables_of(user).each do |scopable|
      scopable.role.permissions.each do |permission|
        add scopable.scopable.model_name.route_key.to_sym,
          scopable.id,
          permission
      end
    end
    
    user.update acl_cache: @acl
    return @acl
  end
  
  def add type, id, permission  
    @acl[type] = {} unless @acl[type]
    if permission.action.to_sym == :read_category
      @acl[type][:visible] = [] unless @acl[type][:visible]
      @acl[type][:visible] << id
      @acl[type][:visible].uniq!
    else
      @acl[type][id] = [] unless @acl[type][id]
      @acl[type][id] << permission.action
      @acl[type][id].uniq!
    end      
  end

  def scopables_of user
    # init
    scopable_ids = []
    
    # collect groups
    Recursion.collect_all(user.groups, :groups).each do |group|
      group.role_scopes.each do |role_scope|
        # category- or group-permission?
        scopable_type = role_scope.scopable.model_name.route_key.to_sym
        
        # collect affected scopables
        scopable_ids << [role_scope.scopable.id]
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
