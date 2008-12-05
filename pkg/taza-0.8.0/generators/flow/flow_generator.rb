require 'rubygems'
require 'rubigen'
require 'activesupport'

class FlowGenerator < RubiGen::Base
  default_options :author => nil
  attr_reader :site_name,:name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.size != 2
    @name = args.shift
    @site_name=args.shift
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
      m.template "flow.rb.erb", File.join('lib','sites', site_name.underscore, "flows",  "#{name.underscore}.rb")
    end
  end

  protected
  def banner
    <<-EOS
    Creates a taza flow for a given taza site, site you are making a flow for must exist first.

    USAGE: #{$0} #{spec.name} flow_name site_name
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
