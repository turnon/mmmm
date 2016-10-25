module Mmmm
  class ObjectMethods

    class FileLineMethod
      attr_reader :file, :line, :method
      def initialize src_loc, m
        @file = src_loc[0]
        @line = src_loc[1]
        @method = m
      end
    end

    def initialize obj
      file = nil
      flm_arr = file_line_method_arr(obj)
      @group_by_file = group_by_file(flm_arr)
    end

    def inspect
      @group_by_file.
	map {|file, flms| "#{file.cyan}\n#{lm_in_string(flms)}" }.
	join("\n")
    end

    private

    def file_line_method_arr obj
      obj.methods.reduce([]) do |rs, m|
        file_line = obj.method(m).source_location
        if file_line
          rs << FileLineMethod.new(file_line, m)
        end
        rs
      end
    end

    def group_by_file flm_arr
      grouped = flm_arr.
	group_by{|flm| flm.file}.
	sort_by{|file, flm| file}

      Hash[grouped]
    end

    def lm_in_string flms
      flms.
	map {|flm| "#{format('%5d', flm.line)} #{flm.method}" }.
	join("\n")
    end
  end
end
