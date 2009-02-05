require 'rubygems'
require 'rubigen'
require 'extensions/string'

class SiteGenerator < RubiGen::Base
  default_options :author => nil
  attr_reader :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @name = args.shift.computerize
    extract_options
  end

  def manifest
    record do |m|
      m.template "site.rb.erb", "lib/#{name}.rb", :collision => :skip
      m.template "environments.yml.erb", "config/environments.yml", :collision => :skip
      m.template "world.rb.erb", "lib/steps/world.rb", :collision => :force
    end
  end
  
  protected
  def banner
    <<-EOS
    Creates the site for a watircraft project.

    USAGE: #{$0} #{spec.name} name
    
    EOS
  end

  def add_options!(opts)
    # opts.separator ''
    # opts.separator 'Options:'
    # For each option below, place the default
    # at the top of the file next to "default_options"
    # opts.on("-a", "--author=\"Your Name\"", String,
    #         "Some comment about this option",
    #         "Default: none") { |options[:author]| }
    # opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
  end

  def extract_options
    # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
    # Templates can access these value via the attr_reader-generated methods, but not the
    # raw instance variable value.
    # @author = options[:author]
  end

end
