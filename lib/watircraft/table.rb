module WatirCraft
  class Table
    class << self
      def row_class
        @row_class ||= Class.new(Row)
      end
      def field(name, &block)
        row_class.field(name, &block)
      end
      def element(name, &block)
        row_class.element(name, &block)
      end
    end
    def initialize watir_table, &block
      @watir_table = watir_table
    end
    def row selector
      @watir_table.rows.each do | row |
        wrapped = self.class.row_class.new row
        # note: we are only looking at the first key/value
        method = selector.keys[0]
        target_value = selector[method]
        row_value = wrapped.send(method) rescue next
        return wrapped if row_value == target_value
      end
      nil
    end
  end
  
  class Row
    class << self
      def element name, &block
        define_method(name) do
          instance_eval &block
        end
      end
      def field name, &block
        element_name = "#{name}_field"
        element element_name, &block
        define_method(name) do
          send(element_name).display_value
        end
        define_method("#{name}=") do | value |
          send(element_name).set value
        end
      end
    end
    attr_reader :row
    def initialize watir_row
      @row = watir_row
    end
    # Returns true. If the row doesn't exist, you'll get nil as the return
    # value of Table#row.
    def exist?
      true
    end
  end
end