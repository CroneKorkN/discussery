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
      group.roles.each do |role|
        # category- or group-permission_type?
        rolable_type = role.rolable.model_name.route_key.to_sym
        
        
        affected_rolable_ids = [role.rolable.id]

        # recursive?
        if role.recursive
          affected_rolable_ids << Recursion.collect(role.rolable, rolable_type).pluck(:id)
          affected_rolable_ids.flatten!.uniq!
        end
        
        p affected_rolable_ids
        
        # apply each permission_type to each affected rolable
        role.role_type.permission_types.each do |permission_type|
          affected_rolable_ids.each do |id|
            add role.rolable.model_name.route_key.to_sym, id, permission_type
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

  def roles_of user
    # init
    rolable_ids = []
    
    # collect groups
    Recursion.collect_all(user.groups, :groups).each do |group|
      group.roles.each do |role|
        # category- or group-permission_type?
        rolable_type = role.rolable.model_name.route_key.to_sym
        
        # collect affected rolables
        p Recursion.collect(role.rolable, rolable_type).pluck(:id) if role.recursive
        rolable_ids << role.id
        rolable_ids << Recursion.collect(role.rolable, rolable_type).pluck(:id) if role.recursive
      end
    end
    
    # return
    return Role.find(rolable_ids.flatten.uniq)
  end

  def category_id_of object
    if object.class.name == "Category"
      object.id
    else
      object.category.id
    end
  end
end
