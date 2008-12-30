module Taza
  # Assumes #site_name and #destination_root and #usage methods are defined.
  module Generator
    def check_if_site_exists
      unless File.exists?(File.join(destination_root,'lib',"#{site_name.underscore}.rb"))
        $stderr.puts "Site #{site_name}.rb does not exist."
        usage
      end
    end    
  end
end