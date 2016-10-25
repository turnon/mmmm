module Mmmm

  class FileLineMethod
    attr_reader :file, :line, :method
    def initialize src_loc, m
      @file = src_loc[0]
      @line = src_loc[1]
      @method = m
    end
  end

  class << self

    def [](obj, method = nil)
      return src_loc obj, method if method
      all_src_loc obj
      nil
    end

    private

    def src_loc obj, method_name
      method = obj.method(method_name)
      puts_location method
      puts_location method while method = method.super_method
    end

    def puts_location method
      file, line = method.source_location
      puts [cyan(file), line].join ' '
    end

    def all_src_loc obj
      file = nil
      file_line_method_arr(obj).sort_by do |flm|
        [flm.file, flm.line]
      end.each do |flm|
        unless file == flm.file
          file = flm.file
          puts cyan file
        end
        puts [format('%5d', flm.line), flm.method].join ' '
      end
    end

    def file_line_method_arr obj
      obj.methods.reduce([]) do |rs, m|
        file_line = obj.method(m).source_location
        if file_line
          rs << FileLineMethod.new(file_line, m)
        end
        rs
      end
    end

    def cyan str
      "\e[36m#{str}\e[0m"
    end
  end
end
