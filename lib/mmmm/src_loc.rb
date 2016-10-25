require 'mmmm/object_method'
require 'mmmm/object_methods'

module Mmmm

  def self.src obj, method = nil
    return ObjectMethod.new(obj, method) if method
    ObjectMethods.new obj
  end

end
