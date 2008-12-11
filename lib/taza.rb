require 'taza/page'
require 'taza/site'
require 'taza/browser'
require 'taza/settings'
require 'taza/flow'
require 'extensions/object'
require 'extensions/string'
require 'extensions/hash'
require 'taza/fixture'

module Taza
  VERSION = '0.8.0'

  def self.windows?
    PLATFORM.include?("mswin")  
  end 
  def self.osx?
    PLATFORM.include?("darwin")
  end
end

module ForwardInitialization
  module ClassMethods
    def new(*args,&block)
      const_get("#{name.split("::").last}").new(*args,&block)
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end
end

