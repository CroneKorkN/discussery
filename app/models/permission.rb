class Permission < ActiveRecord::Base
  has_many :role_permissions, dependent: :destroy
  
  # read
  def self.[](action)
    find_by action: action
  end
end
