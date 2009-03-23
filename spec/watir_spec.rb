require 'spec/spec_helper'
require 'watir'
require 'watir/ie'
require 'extensions/watir'

describe 'Watir Extensions' do
  share_examples_for 'extended watir' do
    it "should provide a display_value method for text fields" do
      container = stub()
      container.stubs(:page_container)
      tf = @module::TextField.new container, :index, 1
      tf.method(:display_value) # should be defined
    end
    
    it "should provide a display_value method for h3's" do
      container = stub()
      container.stubs(:page_container)
      h3 = @module::H3.new container, :index, 1
      h3.method(:display_value) # should be defined
    end
  end

  describe "IE Watir" do
    it_should_behave_like 'extended watir'
    before do
      @module = Watir
    end
  end
end
