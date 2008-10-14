$:.unshift File.dirname(__FILE__)

#require '../../../../lib/selenium'
require 'menu'

module Selenium
  class SeleniumRubyPage < WebPage
    attr_reader :menu

    def initialize(browser, expected_title)
      super(browser, expected_title)
    end

    def menu
      Menu.new(self)
    end
  end
end