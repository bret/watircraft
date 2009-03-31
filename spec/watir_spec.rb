
require 'spec/spec_helper'
require 'watir'
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

  if PLATFORM =~ /mswin/  
    describe "IE Watir" do
      require 'watir/ie'
      it_should_behave_like 'extended watir'
      Watir.add_display_value_methods_to Watir
      before do
        @module = Watir
      end
    end
  end
  
  describe "Fire Watir" do
    it_should_behave_like 'extended watir'
    Watir.add_display_value_methods_to FireWatir
    before do
      @module = FireWatir
    end
  end
end
