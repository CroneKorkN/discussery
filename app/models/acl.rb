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
    
    Recursion.collect_all(user.groups, :groups).each do |group|
      group.role_scopes.each do |role_scope|
        c_ids = [role_scope.scopable.id]
        c_ids << Recursion.collect(role_scope.scopable, :categories).pluck(:id) if role_scope.recursive
        
        c_ids.flatten.each do |c_id|
          @acl[:categories][c_id] = [] unless @acl[:categories][c_id]
          role_scope.role.permissions.each do |permission|
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
