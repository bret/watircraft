class Page
  class << self
    attr_accessor :filters, :elements
  end

  self.filters = Hash.new { [] }
  self.elements = {}

  def self.element(name,&block)
    self.elements[name] = block
  end

  def self.filter(params,&block)
    params[:elements] = [:all] unless params.has_key? :elements

    params[:elements].each do |element|
      self.filters[element] = self.filters[element] << [params[:name],block]
    end
  end

  def initialize
    add_element_methods
  end

  def add_element_methods
    self.class.elements.each do |element_name,element_block|
      filters = self.class.filters[element_name] + self.class.filters[:all]
      add_element_method(:filters => filters, :method_name => element_name, :method_block => element_block)
    end
  end

  def add_element_method(params)
    self.class.class_eval do
      define_method(params[:method_name]) do
        params[:filters].each do |(filter_name,filter_block)|
          unless filter_block.call
            raise FilterError, "#{filter_name} returned false for #{params[:method_name]}"
          end
        end
        params[:method_block].call
      end
    end
  end
end

class FilterError < StandardError; end
