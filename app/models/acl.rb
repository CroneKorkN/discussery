class ACL # Access Controll List
  def initialize(user)
    @acl = user.acl_cache || build_acl(user)
    @acl = build_acl(user)
  end

  def allows(action, object)
    false
    unless object.nil?
      permission = "#{action}_#{object.class.name.downcase}".to_sym
      id = category_id_of object
      puts "#{object.class.name.downcase}; #{permission}"
      if @acl[:category][id] and @acl[:category][id].include?(permission)
        true
      end
    else
      if @acl[:global] and @acl[:global][permission]
        true
      end
    end
  end

  def visible_categories
    @acl[:visible]
  end

private

  {
    category: {
      "1": ["read"]
    },
    visible: [1, 5, 6, 8]
  }

  def build_acl user
    acl = {
      global: [],
      category: {},
      visible: []
    }
    Category.all.each do |category|
      user.user_roles.where(category_id: category.id).each do |user_role|
        acl[:category][category.id] = [] if not acl[:category][category.id]
        user_role.role.permissions.each do |permission|
          acl[:category][category.id] << "#{permission.action}_#{permission.controller.downcase}".to_sym
          acl[:visible] << category.id
        end
      end
    end
    acl[:visible].uniq!
    user.update acl_cache: acl
    acl
  end

  def category_id_of object
    if object.class.name == "Category"
      object.id
    else
      object.category.id
    end
  end
end
