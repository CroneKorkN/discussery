class Recursion
  attr_reader :collection
  
  def initialize object, property
    @collection = Object.const_get(object.class.name).find collect(object, property).flatten
  end
  
  private
  
  def collect object, property
    ids = [object.id]
    object.send(property).each do |subobject|
      ids << collect(subobject, property)
    end
    ids
  end
end