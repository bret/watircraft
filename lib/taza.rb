require 'taza/page'
require 'taza/site'
require 'taza/browser'
require 'taza/settings'
require 'taza/flow'

module Taza
  VERSION = '0.5.0'
  
  def self.windows?
    PLATFORM.include?("mswin")  
  end 
  def self.osx?
    PLATFORM.include?("darwin")
  end
end
