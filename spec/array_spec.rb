require 'spec/spec_helper'

describe 'Array Extensions' do
  it "should know if elements are not equivilent to a subset of those elements" do
    [1,2,3].should_not be_equivalent([2,3])
  end
  it "should know if elements are not equivilent to a larger set including those elements" do
    [1,2,3].should_not be_equivalent([1,2,3,4])
  end  
  it "should know it is equivalent if the same order" do
    [1,2,3].should be_equivalent([1,2,3])
  end
  it "should know it is equivalent if the different orders" do
    [1,2,3].should be_equivalent([2,1,3])
  end
end