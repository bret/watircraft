require 'taza/page'
require 'taza/site'
require 'taza/browser'
require 'taza/settings'
require 'taza/flow'

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

# instance_exec comes with >1.8.7 thankfully
if VERSION <= '1.8.6'
  class Object
    module InstanceExecHelper; end
    include InstanceExecHelper
    def instance_exec(*args, &block)
      begin
        old_critical, Thread.critical = Thread.critical, true
        n = 0
        n += 1 while respond_to?(mname="__instance_exec#{n}")
        InstanceExecHelper.module_eval{ define_method(mname, &block) }
      ensure
        Thread.critical = old_critical
      end
      begin
        ret = send(mname, *args)
      ensure
        InstanceExecHelper.module_eval{ remove_method(mname) } rescue nil
      end
      ret
    end
  end
end
