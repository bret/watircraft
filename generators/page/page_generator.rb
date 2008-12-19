require 'rubygems'
require 'rubigen'
require 'activesupport'
require 'taza/settings'

class PageGenerator < RubiGen::Base
  default_options :author => nil
  attr_reader :site_name,:name

  def initialize(runtime_args, runtime_options = {})
    super
    usage unless (1..2).include? args.size
    @name = args[0]
    @site_name = (args.size == 2) ? args[1] : Taza::Settings.config_file[:default_site]  
    usage if @site_name.nil?
    check_if_site_exists
    extract_options
  end

  def check_if_site_exists
    unless File.directory?(File.join(destination_root,'lib','sites',site_name.underscore))
      $stderr.puts "******No such site #{site_name} exists.******"
      usage
    end
  end

  def manifest
    record do |m|
      m.template "page.rb.erb", File.join('lib','sites', site_name.underscore, "pages",  "#{name.underscore}_page.rb")
      m.template "functional_page_spec.rb.erb", File.join('spec','functional',site_name.underscore,"#{name.underscore}_page_spec.rb")
    end
  end

  protected
  def banner
    <<-EOS
    Creates a taza page for a given taza site, site you are making a page for must exist first.

    USAGE: #{$0} #{spec.name} page_name site_name
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
