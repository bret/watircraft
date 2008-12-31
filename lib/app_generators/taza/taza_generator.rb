require 'rubygems'
require 'rubigen'
class TazaGenerator < RubiGen::Base
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :author => nil

  attr_reader :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name = base_name
    extract_options
    component_generators_path = File.dirname(__FILE__) + '/../../../generators'
    self.class.prepend_sources(
      RubiGen::PathSource.new(:taza, component_generators_path))    
  end

  def manifest
    record do |m|    
      create_directories(m)
      m.template "rakefile.rb.erb", "rakefile"
      m.template "config.yml.erb", "config/config.yml"
      m.template "spec_helper.rb.erb", "test/specs/spec_helper.rb"
      m.template "steps.rb.erb", "test/features/steps.rb"
      m.dependency "install_rubigen_scripts", [destination_root, 'taza'],
        :shebang => options[:shebang], :collision => :force
      m.dependency "site", [@name], :destination => destination_root
    end
  end

  def create_directories(m)
    %w(
      lib
      config
      script
      test
      lib/pages
      lib/steps
      lib/flows
      lib/partials
      test/specs
      test/features
    ).each { |path| m.directory path }
  end
  
  protected
    def banner
      <<-EOS
USAGE: #{spec.name} path/for/your/test/project [options]
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |options[:author]| }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end

end
