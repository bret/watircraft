require 'spec/spec_helper'

describe 'helper function tests' do

  it 'should return NUL in windows' do
    Taza.stubs(:windows?).returns true
    null_device.should eql('NUL')
  end

  it 'should return /dev/null in windows' do
    Taza.stubs(:windows?).returns false
    null_device.should eql('/dev/null')
  end
end
