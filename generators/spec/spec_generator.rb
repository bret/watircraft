require 'rubygems'
require 'rubigen'
require 'activesupport'
require 'watircraft/generator_helper'
require 'extensions/string'

class SpecGenerator < RubiGen::Base
  include WatirCraft::GeneratorHelper
  default_options :author => nil
  attr_reader :name, :site_name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @name = args.shift
    @site_name = configured_validated_site
    extract_options
  end

  def manifest
    record do |m|
      m.template "spec.rb.erb", File.join('test','specs',"#{name.computerize}_spec.rb")
    end
  end

  protected
  def banner
    <<-EOS
    Creates a spec.

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
