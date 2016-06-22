class SettingGroup < ActiveRecord::Base
  belongs_to :setting_group 
  has_many :setting_groups
  has_many :settings
  
  scope :root, ->{ where(setting_group_id: nil) }
end
