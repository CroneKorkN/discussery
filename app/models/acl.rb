class ACL # Access Controll List
  def initialize(user)
    build_for user unless @acl
    @acl
  end

  def allows?(action, category)
    @acl[:categories][category.id] and @acl[:categories][category.id].include?(action.to_sym)
  end
  
  def visible_categories
    @acl[:visible]
  end

private

  def build_for user
    @acl = {
      categories: {},
      visible: []
    }
    
    # todo: group_groups permissions
    Recursion.collect_all(user.groups, :groups).each do |group|
      group.group_roles.each do |group_role|
        c_ids = [group_role.category.id]
        c_ids << Recursion.collect(group_role.category, :categories).pluck(:id) if group_role.recursive
        
        c_ids.flatten.each do |c_id|
          @acl[:categories][c_id] = [] unless @acl[:categories][c_id]
          group_role.role.permissions.each do |permission|
            @acl[:categories][c_id] << permission.action.to_sym
            @acl[:visible] << c_id if permission.action.to_sym == :read_category
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
