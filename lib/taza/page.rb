module Taza
  class Page
    attr_accessor :browser
    class << self
      def elements
        @elements ||= {}
      end
      def filters
        @filters ||= Hash.new { [] }
      end
    end

    def self.element(name,&block)
      self.elements[name] = block
    end

    def self.filter(method_name, *elements)
      elements = [:all] if elements.empty?
      elements.each do |element|
        self.filters[element] = self.filters[element] << method_name
      end
    end

    def initialize
      add_element_methods
    end

    def add_element_methods
      self.class.elements.each do |element_name,element_block|
        filters = self.class.filters[element_name] + self.class.filters[:all]
        add_element_method(:filters => filters, :element_name => element_name, :element_block => element_block)
      end
    end

    def add_element_method(params)
      self.class.class_eval do
        define_method(params[:element_name]) do
          params[:filters].each do |filter_method|
            raise FilterError, "#{filter_method} returned false for #{params[:element_name]}" unless send(filter_method)
          end
          self.instance_eval(&params[:element_block])
        end
      end
    end
  end

  class FilterError < StandardError; end
end
