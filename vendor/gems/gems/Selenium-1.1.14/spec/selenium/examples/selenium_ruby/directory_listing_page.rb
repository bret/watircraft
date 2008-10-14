$:.unshift File.dirname(__FILE__)

module Selenium
  class DirectoryListingPage < WebPage
    def initialize(browser)
      super(browser, 'Index of /')
    end
  end
end