class Authorization
  def initialize(user, action, object)
    raise "#{user.name} #{action} #{object.class.name if object} #{object.id if object} authorization error" unless user.acl.allows action, object
  end
end