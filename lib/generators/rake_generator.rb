require 'erb'

class RakeGenerator
  def initialize(path)
    @path = path
  end

  def generate
    contents = render_template
    write_file(contents)
  end

  def render_template
    template = ERB.new(read_template)
    template.result(binding)
  end

  def write_file(contents)
    File.open(@path,"w") do |out|
      out << contents
    end
  end

  def read_template
    File.read(File.join(File.dirname(__FILE__),"templates","rakefile.rb.erb"))
  end
end
