require 'spec/spec_helper'
require 'taza/page'
require 'taza/site'
require 'spec/fake_table'

describe FakeTable do
  
  it "has rows" do
    @fake_table = FakeTable.new [{},{}]
    @fake_table.rows.length.should == 2
  end
  
  it "has fake rows" do
    @fake_table = FakeTable.new [{:name => 'apple'}]
    @fake_table.rows[0].should be_a(FakeRow)
  end    

  # Note: the way it fakes out elements is the least
  # authentic aspect of this scheme
  it "has rows with elements and display values" do
    @fake_table = FakeTable.new [{:name => 'apple'}]
    @fake_table.rows[0].element(:name).display_value.should == 'apple'
  end
  
end

