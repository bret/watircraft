$:.unshift File.join(File.dirname(__FILE__))

require 'menu'

module Selenium
  class LicensePage < SeleniumRubyPage
    def initialize(browser)
      super(browser, 'Selenium Ruby - License')
    end
  end
end