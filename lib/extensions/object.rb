# instance_exec comes with >1.8.7 thankfully
if VERSION <= '1.8.6'
  class Object
    module InstanceExecHelper; end
    include InstanceExecHelper
    # instance_exec method evaluates a block of code relative to the specified object, with parameters whom come from outside the object.
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
