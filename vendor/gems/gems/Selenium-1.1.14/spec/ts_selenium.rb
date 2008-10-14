$:.unshift(File.dirname(__FILE__))

root = File.join(File.dirname(__FILE__))
Dir.glob("#{root}/**/tc_*.rb") do |file|
  require "#{file}"
end
