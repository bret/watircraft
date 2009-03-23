require 'spec/spec_helper'
require 'watir'
require 'watir/ie'
require 'extensions/watir'

describe 'Watir Extensions' do
  it "should provide a display_value method for text fields" do
    container = stub()
    container.stubs(:page_container)
    tf = Watir::TextField.new container, :index, 1
    tf.method(:display_value) # should be defined
  end
  
  it "should provide a display_value method for h3's" do
    container = stub()
    container.stubs(:page_container)
    h3 = Watir::H3.new container, :index, 1
    h3.method(:display_value) # should be defined
  end
end
