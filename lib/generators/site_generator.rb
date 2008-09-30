require 'need'
need { 'base_generator' }

class SiteGenerator < BaseGenerator
  attr_accessor :file_name
  
  def initialize(file_name)
    @file_name = file_name
  end
  
  def folder_path
    File.join('lib','sites')
  end
  
  def generate
    file "site.rb.erb", File.join(folder_path,"#{file_name}.rb")
    folder File.join(folder_path,"#{file_name}")
    folder File.join(folder_path,"#{file_name}","flows")
    folder File.join(folder_path,"#{file_name}","pages")
  end
end
