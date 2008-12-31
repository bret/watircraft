require 'rubygems'
require 'rubigen'
require 'activesupport'
require 'taza/settings'
require 'taza/generator_helper'

class PageGenerator < RubiGen::Base
  include Taza::GeneratorHelper
  default_options :author => nil
  attr_reader :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage unless args.size == 1
    @name = args[0]
    @site_name = site_name
    check_if_site_exists
    extract_options
  end

  def site_name
    Taza::Settings.config_file['site']
  end
  
  def manifest
    record do |m|
      m.template "page.rb.erb", File.join('lib', 'pages', "#{name.underscore}_page.rb")
    end
  end

  protected

  def banner
    <<-EOS
    Creates a taza page for the current site.

    USAGE: #{$0} #{spec.name} page_name
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
