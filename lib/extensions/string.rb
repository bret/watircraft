require 'rubygems'
require 'activesupport'

class String
  def pluralize_to_sym
    self.pluralize.to_sym
  end
end