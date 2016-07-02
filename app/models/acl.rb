class ACL # Access Controll List
  def initialize(user)
    build_for user unless @acl
    @acl
  end

  def allows?(action, object)
    object_type = object.model_name.route_key.to_sym
    @acl[object_type][object.id] and @acl[object_type][object.id].include?(action.to_sym)
  end
  
  def visible objects
    objects = objects.to_sym
    @acl[objects][:visible] if @acl[objects]
  end

  private
  
  def build_for user
    @acl = {}
    # collect groups
    Recursion.collect_all(user.groups, :membership_groups).each do |group|
      group.roles.each do |role|
        # category- or group-permission_type?
        protectable_type = role.protectable.model_name.route_key.to_sym
        affected_protectable_ids = [role.protectable.id]

        # recursively?
        if role.recursive
          affected_protectable_ids << Recursion.collect(role.protectable, protectable_type).pluck(:id)
          affected_protectable_ids.flatten!.uniq!
        end
        
        # apply each permission_type to each affected protectable
        role.permission_types.each do |permission_type|
          affected_protectable_ids.each do |id|
            add role.protectable.model_name.route_key.to_sym, id, permission_type
          end
        end
      end
    end
    
    user.update acl_cache: @acl
    return @acl
  end
  
  def add type, id, permission_type
    visibility_permission = PermissionType.find(Setting[:visibility_permission_type_id]).action
    
    @acl[type] = {} unless @acl[type]
    @acl[type][id] = [] unless @acl[type][id]
    @acl[type][id] << permission_type.action.to_sym
    if permission_type.action == visibility_permission
      @acl[type][:visible] = [] unless @acl[type][:visible]
      @acl[type][:visible] << id
      @acl[type][:visible].uniq!
    end
    return true
  end

  def roles_of user
    # init
    protectable_ids = []
    
    # collect groups
    Recursion.collect_all(user.groups, :groups).each do |group|
      group.roles.each do |role|
        # category- or group-permission_type?
        protectable_type = role.protectable.model_name.route_key.to_sym
        
        # collect affected protectables
        p Recursion.collect(role.protectable, protectable_type).pluck(:id) if role.recursive
        protectable_ids << role.id
        protectable_ids << Recursion.collect(role.protectable, protectable_type).pluck(:id) if role.recursive
      end
    end
    
    # return
    return Role.find(protectable_ids.flatten.uniq)
  end

  def category_id_of object
    if object.class.name == "Category"
      object.id
    else
      object.category.id
    end
  end
end
