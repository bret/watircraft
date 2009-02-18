require 'extensions/string'

module Taza
  # An abstraction of a web page, place the elements you care about accessing in here as well as specify the filters that apply when trying to access the element.
  #
  # Example:
  #   require 'taza'
  #   class HomePage < Taza::Page
  #     element(:foo) {browser.element_by_xpath('some xpath')}
  #     filter :title_given, :foo
  #
  #     def title_given
  #       browser.title.nil?
  #     end
  #   end
  #
  # homepage.foo will return the element specified in the block if the filter returned true
  class Page
    attr_accessor :browser, :site

    class << self

      def elements # :nodoc:
        @elements ||= {}
      end

      def filters # :nodoc:
        @filters ||= Hash.new { [] }
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
        self.elements[name] = block
      end

      # An element on a page that has a value.
      # Use #field for input elements and data elements.
      #
      #   class HomePage < Taza::Page
      #     field(:name) {browser.text_field(:name, 'user_name')}
      #   end
      #
      # home_page.name_field    # returns the text_field element
      # home_page.name_field.exists?
      # home_page.name = "Fred" # calls the #set method on the text_field
      # home_page.name          # returns the current value (display_value) of the text_field
      #
      # The following Watir elements provide both #set and #display_value methods
      #   text_field (both text boxes and text areas)
      #   hidden
      #   file_field
      #   select_list
      #   checkbox
      #   (radios are the obvious item missing from this list -- we're working on it.)
      #
      # The following Watir elements provide #display_value methods (but not #set methods).
      #   button
      #   cell
      #   hidden
      #   all non-control elements, including divs, spans and most other elements.
      def field(name, suffix='field', &block)
        name = name.to_s.computerize.to_sym
        element_name = "#{name}_#{suffix}"
        self.elements[element_name] = block
        self.class_eval <<-EOS
          def #{name}()
            #{element_name}.display_value
          end
        EOS
        self.class_eval <<-EOS
          def #{name}= value
            #{element_name}.set value
          end
        EOS
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
    
    def populate hash
      hash.each do |key, value|
        send "#{key}=", value
      end
    end

    def validate hash
      hash.each do |key, value|
        send(key).should == value
      end
    end
  
  end

  class FilterError < StandardError; end
    
end
