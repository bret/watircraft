require 'erb'
require 'need'
need { 'base_generator' }
class RakeGenerator < BaseGenerator
  def initialize(path)
    @path = path
  end
  def generate
    file "rakefile.rb.erb", File.join(@path,"rakefile")
  end
end