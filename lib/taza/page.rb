require 'extensions/string'
require 'watir/exceptions' # so we can trap them
require 'watircraft/table'

module Taza
  # An abstraction of a web page, place the elements you care about accessing in here as well as specify the filters that apply when trying to access the element.
  #
  # Example:
  #   require 'taza'
  #   class HomePage < Taza::Page
  #     element(:submit) {browser.button(:value, 'Submit')}
  #     filter :title_given, :foo
  #
  #     def title_given
  #       browser.title.nil?
  #     end
  #   end
  #
  # home_page.submit will return the button specified if the filter returned true
  class Page
    attr_accessor :browser, :site

    class << self

      def elements # :nodoc:
        @elements ||= {}
      end

      def filters # :nodoc:
        @filters ||= Hash.new { [] }
      end

      def fields # :nodoc:
        @fields ||= []
      end

      def url string=nil
        if string.nil?
          @url
        else
          @url = string
        end
      end

      # An element on a page
      #
      # Watir Example:
      #   class HomePage < Taza::Page
      #     element(:next_button) {browser.button(:value, 'Next'}
      #   end
      # home_page.next_button.click
      def element(name, &block)
        name = name.to_s.computerize.to_sym
        elements[name] = block
      end

      # An element on a page that has a value.
      # Use #field for input elements and data elements.
      #
      #   class HomePage < Taza::Page
      #     field(:name) {browser.text_field(:name, 'user_name')}
      #   end
      #
      #   home_page.name_field    # returns the text element
      #   home_page.name_field.exists?
      #   home_page.name = "Fred" # sets the text element (A)
      #   home_page.name          # returns the value of the text element (B)
      #
      # The following Watir elements provide both #set (A) and #display_value (B) methods
      #   text_field (both text boxes and text areas)
      #   file_field
      #   select_list
      #   checkbox
      #
      # Most other Watir elements provide #display_value (B) methods only.
      def field(name, suffix='field', &block)
        name = name.to_s.computerize.to_sym
        fields << name
        element_name = "#{name}_#{suffix}"
        elements[element_name] = block
        define_method(name) do
          send(element_name).display_value
        end
        define_method("#{name}=") do |value|
          send(element_name).set value
        end
        element_name
      end
  
      # A filter for element(s) on a page
      # Example:
      #   class HomePage < Taza::Page
      #     element(:foo) {browser.element_by_xpath('some xpath')}
      #     filter :title_given, :foo
      #     #a filter will apply to all elements if none are specified
      #     filter :some_filter
      #     #a filter will also apply to all elements if the symbol :all is given
      #     filter :another_filter, :all
      #
      #     def some_filter
      #       true
      #     end
      #
      #     def some_filter
      #       true
      #     end
      #
      #     def title_given
      #       browser.title.nil?
      #     end
      #   end
      def filter(method_name, *elements)
        elements = [:all] if elements.empty?
        elements.each do |element|
          self.filters[element] = self.filters[element] << method_name
        end
      end
      
      # Provides access to a WatirCraft::Table. 
      #
      # Requires that an element also be declared on the page that directly
      # wraps the table element itself.
      #      
      # Example definition
      #
      #  class YourCartPage < ::Taza::Page
      #    element(:items_table) {@browser.table(:index, 1)}
      #    table(:items) do
      #      field(:quantity) {@row.cell(:index, 1)}
      #      field(:description) {@row.cell(:index, 2)}
      #    end
      #    field(:total) {@browser.cell(:id, 'totalcell')}
      #
      # Example usage
      #
      #   your_cart_page.items.row(:description => 'Pragmatic Project Automation').quantity.should == '1'
      #
      # Technical details: this method creates a 
      # subclass and then allows its class methods to define fields and 
      # elements on the table.
      def table(name, &block)
        # create subclass for the table
        sub_class = Class.new(WatirCraft::Table)
        sub_class.class_eval &block
        # add method to the page, it returns an instance of the table subclass
        define_method(name) do
          sub_class.new send("#{name}_table")
        end
      end
    end

    def initialize
      add_element_methods
      @active_filters = []
    end

    def add_element_methods # :nodoc:
      self.class.elements.each do |element_name,element_block|
        filters = self.class.filters[element_name] + self.class.filters[:all]
        add_element_method(:filters => filters, :element_name => element_name, :element_block => element_block)
      end
    end

    def add_element_method(params) # :nodoc:
      self.class.class_eval do
        define_method(params[:element_name]) do |*args|
          check_filters(params)
          self.instance_exec(*args,&params[:element_block])
        end
      end
    end

    def check_filters(params) # :nodoc:
      params[:filters].each do |filter_method|
        unless @active_filters.include?(filter_method)
          @active_filters << filter_method
          raise FilterError, "#{filter_method} returned false for #{params[:element_name]}" unless send(filter_method)
          @active_filters.delete(filter_method)
        end
      end
    end
    
    # Go to this page. Url is computed based the page url and the url from the
    # Site & Settings.
    def goto
      @site.goto self.class.url
    end

    # Return the full url expected for the page, taking into account the Site 
    # and settings.
    def full_url
      File.join(@site.origin, self.class.url)
    end
    alias :url :full_url
    
    # Enter values into fields on the page using a hash, using the key of
    # each pair to name the field.
    def populate hash
      hash.each do |key, value|
        send "#{key}=", value
      end
    end

    # Verify that the fields specified by the keys in the hash correspond to the
    # provided values.
    def validate hash
      hash.each do |key, value|
        send(key).should == value
      end
    end
    
    # Return the names of the elements defined for the page.    
    def elements
      self.class.elements.keys.map &:to_s
    end
    
    # Return the names of the fields defined for the page.
    def fields
      self.class.fields.map &:to_s
    end
    
    # Returns a hash with the names and values of the specified fields.
    # If no fields are specifieds, all fields on the page are used.
    def values field_names=fields
      result = {}
      field_names.each { |name| result[name.to_sym] = send(name)}
      result
    end
    
    include Watir::Exception
    def element_exist? name
      begin
        send(name).exist?
      rescue UnknownFrameException, UnknownObjectException, 
          UnknownFormException, UnknownCellException
        false
      end
    end
    alias :element_exists? :element_exist?
  
    def elements_exist? element_names=elements
      result = {}
      element_names.each do |element| 
        result[element.to_sym] = element_exist?(element)
      end
      result
    end
    alias :elements_exists? :elements_exist?
  
  end

  class FilterError < StandardError; end
    
end
