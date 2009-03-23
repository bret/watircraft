require 'spec/spec_helper'
require 'watir'
require 'watir/ie'
require 'firewatir'
require 'extensions/watir'

describe 'Watir Extensions' do
  share_examples_for 'extended watir' do
    def should_provide_display_value_method_for_class klass
      container = stub()
      container.stubs(:page_container)
      element = klass.new container, :index, 1
      element.method(:display_value) # should be defined
    end
    
    specify { should_provide_display_value_method_for_class @module::TextField }
    specify { should_provide_display_value_method_for_class @module::NonControlElement}
    specify { should_provide_display_value_method_for_class @module::H3 }
  end

  describe "IE Watir" do
    it_should_behave_like 'extended watir'
    before do
      @module = Watir
    end
  end
  
  describe "Fire Watir" do
    it_should_behave_like 'extended watir'
    before do
      @module = FireWatir
    end
  end
end
