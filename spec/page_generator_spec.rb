require 'rubygems'
require 'need'
require 'fileutils'
need { 'spec_helper' }
need { '../lib/generators/page_generator' }

describe PageGenerator do

  it "should have a template file in the templates directory" do
    File.exists?('lib/generators/templates/page.rb.erb').should be_true
  end

  it "should generate a page file in lib/\#{site_name}/pages/"
  it "should generate a file that can be required"
end
