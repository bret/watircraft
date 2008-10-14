$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'spec'
require 'lib/selenium'

#START GOOGLEHOME
class GoogleHomPage < Selenium::WebPage
  def initialize(browser)
    super(browser, 'Google')
  end

  def title
    browser.get_title
  end

  def search_field
    text_field(:name, 'q')
  end

  def search_button
    button(:name, 'btnG')
  end

end
#END GOOGLEHOME

context 'Test goole search' do
  before(:all) do
    port = 4567
    @server = Selenium::Server.on_port(port)
    @server.start
  end

  before(:each) do
    @webpage = @server.open('*chrome D:\Program Files\Mozilla Firefox2\firefox.exe', 'http://www.google.com/webhp')
  end

  after(:each) do
    @webpage.close if @webpage
  end

  after(:all) do
    puts "stopping server"
    @server.stop
  end

#START DOMAIN
  specify'searh hello world with google using docmain based script' do
    page = GoogleHomPage.new(@webpage.browser)
    page.should be_present
    page.search_field.enter('hello world')
    page.search_button.click_wait
    page.title.should == 'hello world - Google Search'
    page.search_field.value.should == 'hello world'
  end
#END DOMAIN

end
