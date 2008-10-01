require 'rubygems'
require 'erb'
require 'need'
need { 'base_generator' }
class ProjectGenerator < BaseGenerator
  def initialize(path)
    @path = path
  end
  def generate
    folder @path 
    file "rakefile.rb.erb", File.join(@path,"rakefile")
    folder File.join(@path,"lib")
    folder File.join(@path,"lib","sites")
    folder File.join(@path,"lib","flows")
  end
end
