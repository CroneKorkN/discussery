class PermissionType < ActiveRecord::Base
  has_many :permissions, dependent: :destroy
  
  # read
  def self.[](action)
    find_by action: action
  end
end
