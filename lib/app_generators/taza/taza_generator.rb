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
  end

  def manifest
    record do |m|    
      create_directories(m)
      m.template "rakefile.rb.erb", "rakefile"
      m.template "config.yml.erb", File.join("config","config.yml")
      m.template "spec_helper.rb.erb", File.join("spec","spec_helper.rb")
      m.dependency "install_rubigen_scripts", [destination_root, 'taza'],
        :shebang => options[:shebang], :collision => :force
    end
  end

  def create_directories(m)
    BASEDIRS.each { |path| m.directory path }
    m.directory File.join('lib','pages')
    m.directory File.join('lib','steps')
    m.directory File.join('lib','flows')
    m.directory File.join('lib','partials')
    m.directory File.join('spec','functional')
    m.directory File.join('spec','features')
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

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      lib
      config
      script
      spec
    )
end
