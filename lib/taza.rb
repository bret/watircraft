require 'taza/page'
require 'taza/site'
require 'taza/browser'
require 'taza/settings'
require 'taza/flow'
require 'taza/entity'
require 'taza/fixture'
require 'extensions/object'
require 'extensions/string'
require 'extensions/hash'
require 'extensions/array'

module Taza
  VERSION = '0.8.1'

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

