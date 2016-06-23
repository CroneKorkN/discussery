class Authorization
  def initialize(user, action, category)
    raise "#{user.name} #{action} in category #{category.id} authorization error" unless user.acl.allows? action, category
  end
end