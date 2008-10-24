require 'rubygems'
require 'rubigen'
require 'activesupport'

class PageGenerator < RubiGen::Base
  default_options :author => nil
  attr_reader :site_name,:name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @name = args.shift
    @site_name=args.shift
    extract_options
  end
  
  def manifest
    record do |m|
      m.template "page.rb.erb", File.join('lib','sites', site_name.underscore, "pages",  "#{name.underscore}.rb")
      m.template "functional_page_spec.rb.erb", File.join('spec','functional',site_name.underscore,"#{name.underscore}_spec.rb")
    end
  end

  protected
  def banner
    <<-EOS
    Creates a ...

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
