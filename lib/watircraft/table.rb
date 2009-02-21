module WatirCraft
  class Table
    class << self
      def row_class
        @row_class ||= Class.new(Row)
      end
      def field(name, &block)
        row_class.field(name, &block)
      end
    end
    def initialize watir_table, &block
      @watir_table = watir_table
    end
    def row selector
      @watir_table.rows.select do | row |
        wrapped = self.class.row_class.new row
        method = selector.keys[0]
        value = selector[method]
        return wrapped if wrapped.send(method) == value
      end
      nil
    end
  end
  
  class Row
    class << self
      def field name, &block
        element = "#{name}_element"
        define_method(element) do
          instance_eval &block
        end
        define_method(name) do
          send(element).display_value
        end
      end
    end
    def initialize watir_row
      @row = watir_row
    end
  end
end