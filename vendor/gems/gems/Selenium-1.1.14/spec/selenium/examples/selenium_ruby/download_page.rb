$:.unshift File.dirname(__FILE__)
require 'menu'
require 'web_page'

module Selenium
class DownloadPage < SeleniumRubyPage
  def initialize(browser)
    super(browser, 'Selenium Ruby - Download')
  end
end  
end
