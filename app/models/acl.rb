class ACL # Access Controll List
  def initialize(user)
    build_for user unless @acl
    @acl
  end

def allows?(action, category=Category.find(Setting["global_category_id"]))
    false
    if @acl[:categories][category.id] and @acl[:categories][category.id].include?(action)
      true
    end
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
    user.groups.each do |group|
      group.group_roles.each do |group_role|
        c_id = group_role.category.id
        @acl[:categories][c_id] = [] unless @acl[:categories][c_id]
        group_role.role.permissions.each do |permission|
          @acl[:categories][c_id] << permission.action
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
