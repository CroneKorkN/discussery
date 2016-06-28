class Recursion
  def self.collect object, relation
    Object.const_get(object.class.name).find dig(object, relation)
  end
  
  def self.collect_all objects, relation
    objects.each do |object|
      collect object, relation
    end      
  end
  
  private
  
  def self.dig object, relation
    ids = [object.id]
    object.send(relation).each do |subobject|
      ids << dig(subobject, relation)
    end
    ids.flatten
  end
end