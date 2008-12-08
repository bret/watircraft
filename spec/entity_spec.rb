require 'spec/spec_helper'
require 'taza/entity'

describe 'Taza::Entity' do
  it "should add methods for hash string keys" do
    entry = Taza::Entity.new({'apple' => 'pie'})
    entry.apple.should eql('pie')
  end
end