class Authorization
  def initialize(user, action, category)
    raise "category #{category.id} authorization error: #{user.name} #{action}" unless user.acl.allows? action, category
  end
end