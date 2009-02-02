require 'rubygems'
require 'rubigen'
class WatircraftGenerator < RubiGen::Base
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :author => nil

  attr_reader :name, :site

  component_generators_path = File.dirname(__FILE__) + '/../../../watircraft_generators'
  prepend_sources(RubiGen::PathSource.new(:watircraft, component_generators_path))    

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name = base_name
    extract_options
    @site ||= @name
  end

  def manifest
    record do |m|    
      @@new_directories.each { |path| m.directory path }
      m.template "rakefile.rb.erb", "rakefile"
      m.template "config.yml.erb", "config/config.yml"
      m.template "spec_helper.rb.erb", "test/specs/spec_helper.rb"
      m.template "feature_helper.rb.erb", "test/features/feature_helper.rb"
      m.template "initialize.rb.erb", "lib/initialize.rb"
      m.dependency "install_rubigen_scripts", [destination_root, 'watircraft'],
        :shebang => options[:shebang], :collision => :force
      m.dependency "site", [@site], :destination => destination_root
    end
  end

  @@new_directories =
    %w(
      lib
      config
      script
      test
      lib/pages
      lib/steps
      test/specs
      test/features
    )  
  
  protected
    def banner
      <<-EOS
USAGE: #{spec.name} project_name [options]
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
      opts.on("--site=SITE", String, 
        "Name of the Site for the project.",
        "Default: same as project_name."
        ) { |v| options[:site] = v }
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
      @site = options[:site]
    end

end
