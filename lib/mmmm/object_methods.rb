module Mmmm
  class ObjectMethods

    class FileLineMethod
      attr_reader :file, :line, :method
      def initialize src_loc, m, inherited
        @file = src_loc[0]
        @line = src_loc[1]
        @method = m
        @inherited = inherited
      end

      def inherited?
        @inherited
      end
    end

    def initialize obj
      @obj = obj
    end

    def inspect
      group_by_inherited_and_file.
        map { |inh_file, flms| "#{inh_file[1].cyan} #{inh_file[0]}\n#{lm_in_string(flms)}" }.
        join("\n")
    end

    private

    def file_line_method_arr
      @obj.methods.each_with_object([]) do |m, rs|
        file_line = @obj.method(m).source_location
        rs << FileLineMethod.new(file_line, m, inherited?(m)) if file_line
      end
    end

    def inherited? method
      not open_class_defined_methods.include? method
    end

    def open_class_defined_methods
      @ocdm ||= [:singleton_class, :class].
        map{ |klass| @obj.send(klass).instance_methods(false) }.
        flatten.
        uniq
    end

    def group_by_inherited_and_file
      grouped = file_line_method_arr.
        group_by{ |flm| [flm.inherited?.to_s, flm.file] }.
        sort_by{ |inh_f, _| inh_f }

      Hash[grouped]
    end

    def lm_in_string flms
      flms.
        map {|flm| "#{format('%5d', flm.line)} #{flm.method}" }.
        join("\n")
    end
  end
end
