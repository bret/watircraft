class BaseGenerator  
  def file(template_file_name,output_file)
    write_file(output_file,render_template(template_file_name))
  end
  
  def render_template(template_file_name)
    template = ERB.new(read_template(template_file_name))
    template.result(binding)
  end
  
  def folder(path)
    underscored_path = Inflector.underscore(path)
    Dir.mkdir(underscored_path) unless File.directory?(underscored_path)
  end
  
  def write_file(output_file,contents)
    File.open(Inflector.underscore(output_file),"w") do |out|
      out << contents
    end
  end
  
  def read_template(template_file_name)
    File.read(File.join(File.dirname(__FILE__),"templates",template_file_name))
  end
end