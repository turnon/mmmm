Mmmm::Top = self

module Mmmm

  Helper = Proc.new do |obj, method = nil|
    Mmmm.src obj, method
  end

  class << self

    def helper name
      if Mmmm::Top.respond_to? name or
        Mmmm::Top.private_methods.include? name
	raise NameError,"#{name} is already defined. Please use Mmmm.helper(:another_name)"
        return
      end
      define_helper_method name
    end

    private

    def define_helper_method name
      (class << Top; self; end).send :define_method, name, Helper
    end

  end

end
