require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium'
require 'spec/selenium/examples/selenium_ruby/home_page'
require 'spec/selenium/examples/selenium_ruby/download_page'

module Selenium
describe 'basic operation with selenium' do
  before do
    port = 4567
    @server = Selenium::Server.on_port(port)
    @server.start
    @webpage = @server.open("*iexplore", 'http://localhost:2000/index.html')
    @browser = @webpage.browser
  end

  after do
    @webpage.close
    @server.stop
  end
  
  it 'should click through menus' do
#TEST START
    page = HomePage.new(@browser)
    page.menu.download_link.click_wait
    page = DownloadPage.new(@browser)
    page.should be_present
    page = page.menu.home_link.go
    page.link(:text, 'index.txt').click_wait
    page = HomePage.new(@browser)
    page.menu.license_link.go
#TEST END
  end
end
end