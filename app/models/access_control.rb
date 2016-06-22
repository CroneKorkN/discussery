class AccessControl
  def self.authorize(user: nil, to: nil, object: nil)
    if false
      raise Exceptions::AuthorizationError
        .new("\"#{to} #{object || "gobally"}\" prohibited")
    end
  end
  
  def self.category_ids_visibile_for user
    0..99
  end
end