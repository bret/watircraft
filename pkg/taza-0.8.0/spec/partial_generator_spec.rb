require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'
require 'vendor/gems/gems/rubigen-1.3.2/test/test_generator_helper'

describe "Partial Generation" do
  include RubiGen::GeneratorTestHelper
  include Helpers::Generator
  include Helpers::Taza

  before :all do
    @site_name = "Foo"
    @site_folder = File.join(PROJECT_FOLDER,'lib','sites',"gap")
    @site_file = File.join(PROJECT_FOLDER,'lib','sites',"gap.rb")
    @partial_name = "Header"
  end

  before :each do
    run_generator('taza', [APP_ROOT], generator_sources)
    @site_class = generate_site(@site_name)
  end

  after :each do
    bare_teardown
  end

  it "should give you usage if you do not give two arguments" do
    PartialGenerator.any_instance.expects(:usage)
    lambda { run_generator('partial', [@partial_name], generator_sources) }.should raise_error
  end

  it "should give you usage if you give a site that does not exist" do
    PartialGenerator.any_instance.expects(:usage)
    $stderr.expects(:puts).with(regexp_matches(/NoSuchSite/))
    lambda { run_generator('partial', [@partial_name,"NoSuchSite"], generator_sources) }.should raise_error
  end

end
