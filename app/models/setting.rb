class Setting < ActiveRecord::Base
  belongs_to :setting_group
  @@cache = {}
  
  # read
  def self.[](key)
    return @@cache[key] if @@cache[key]
    if setting = find_by(key: key)
      @@cache[key] = setting.value
      return setting.value
    else
      raise "Setting '#{setting_key}' not found."
    end
  end
  
  # write
  def self.[]=(key, value)
    if setting = find_by_key(key)
      setting.update(value: value)
    else
      raise "Setting '#{setting_key}' not found."
    end    
  end
end