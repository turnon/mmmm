module Mmmm
  class ObjectMethod
    def initialize obj, method_name
      ancs = all_ancestors(obj)
      @locs_in_all_ancs = instance_method_locations(method_name, ancs)
    end

    def inspect
      @locs_in_all_ancs.
        map{ |file, line| [file.cyan, line].join(' ') }.
        join("\n")
    end

    private

    def all_ancestors obj
      obj.
        singleton_class.
        ancestors
    end

    def instance_method_locations method_name, mods
      mods.each_with_object([]) do |class_or_module, locs|
            loc = instance_method_location method_name, class_or_module
            locs << loc unless loc.nil?
           end.
           uniq
    end

    def instance_method_location method_name, mod
      mod.instance_method(method_name).source_location
    rescue NameError => e
      nil
    end
  end
end
