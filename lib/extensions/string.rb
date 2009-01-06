require 'rubygems'
require 'activesupport'

class String
  # pluralizes a string and turns it into a symbol
  # Example:
  #  "apple".pluralize_to_sym    # => :apples
  def pluralize_to_sym
    self.pluralize.to_sym
  end
  # Opposite of humanize. Converts to lower case and converts spaces to underscores. 
  # Example:
  #   "Add Book".computerize # => "add_book"
  def computerize
    self.downcase.gsub ' ', '_'
  end
end