require 'rubygems'
require 'rubigen'
require 'extensions/string'
require 'watircraft/version'

class WatircraftGenerator < RubiGen::Base
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :author => nil

  attr_reader :name, :site, :driver

  # so we can use the site generator
  prepend_sources(RubiGen::GemPathSource.new([:watircraft]))

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name = base_name
    extract_options
    @site ||= installed_site || @name
    @site = @site.computerize
  end
  
  # return the site name if we are upgrading an existing project
  def installed_site
    return nil unless File.exists? @destination_root + "/config/config.yml"
    require 'taza/settings'
    initializer = @destination_root + "/lib/initialize.rb"
    load initializer if File.exists? initializer
    Taza::Settings.path = @destination_root
    Taza::Settings.config[:site]
  end

  def manifest
    record do |m|    
      @@new_directories.each { |path| m.directory path }

      m.file "rakefile.rb", "rakefile", :collision => :force
      m.template "config.yml.erb", "config/config.yml", :collision => :skip

      m.file "spec_helper.rb", "test/specs/spec_helper.rb", :collision => :force
      m.file "feature_helper.rb", "test/features/feature_helper.rb", :collision => :force

      m.template "initialize.rb.erb", "lib/initialize.rb", :collision => :skip # not sure what's right
      m.file "spec_initialize.rb", "lib/init/spec_initialize.rb", :collision => :force
      m.file "world.rb", "lib/steps/world.rb", :collision => :force
      m.template "site_start.rb.erb", "lib/init/site_start.rb", :collision => :force
      
      m.file_copy_each ["console", "console.cmd"], "script", :collision => :force 

      m.dependency "install_rubigen_scripts", [destination_root, 'watircraft'],
        :shebang => options[:shebang], :collision => :ask

      m.template "site.rb.erb", "lib/#{@site}.rb", :collision => :skip
      m.template "environments.yml.erb", "config/environments.yml", :collision => :skip
      
      m.readme "readme.txt"
    end
  end

  @@new_directories =
    %w(
      config
      script
      lib
      lib/init
      lib/pages
      lib/steps
      test
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
        "Default: existing site (if updating) or project_name."
        ) { |v| options[:site] = v }
      opts.on("--driver=DRIVER", String,
        "Name of the browser driver for the project.",
        "Default: watir."
        ) { |v| options[:driver] = v }
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
      @site = options[:site]
      @driver = options[:driver] || 'watir'
    end

end
