require 'taza/generators'
require 'taza/page'
require 'taza/site'
require 'taza/tasks'
require 'taza/browser'

module Taza
  VERSION = '0.5.0'
  
  def self.windows?
    PLATFORM.include?("mswin")  
  end 
  
end
