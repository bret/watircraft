require 'rubygems'
require 'rubigen'
require 'activesupport'

class SiteGenerator < RubiGen::Base
  default_options :author => nil
  attr_reader :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @name = args.shift
    extract_options
  end

  def manifest
    record do |m|
      site_path = File.join('lib','sites')
      m.template "site.rb.erb", File.join(site_path,"#{name.underscore}.rb")
      m.directory File.join(site_path,"#{name.underscore}")
      m.directory File.join(site_path,("#{name.underscore}"),"flows")
      m.directory File.join(site_path,("#{name.underscore}"),"pages")
      m.directory File.join(site_path,("#{name.underscore}"),"pages","partials")
      m.directory File.join('spec','functional',name.underscore)
      m.template "site.yml.erb", File.join('config',"#{name.underscore}.yml")
    end
  end

  protected
  def banner
    <<-EOS
    Creates a taza site.

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
