require 'taza/generators'
require 'taza/page'
require 'taza/site'
require 'taza/tasks'

module Taza
  VERSION = '1.0.0'
  
  def self.windows?
    PLATFORM.include?("mswin")  
  end 
  
end