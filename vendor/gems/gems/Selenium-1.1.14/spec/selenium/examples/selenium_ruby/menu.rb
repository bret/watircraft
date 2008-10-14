$:.unshift File.dirname(__FILE__)

require 'home_page'
require 'directory_listing_page'
require 'license_page'

module Selenium
  class Menu
    attr_reader :webpage
    def initialize(webpage)
      @webpage = webpage
    end

    def home_link
      # todo there should be a way to alter this instance so that the click returns the directory listing page
      webpage.link(:id, 'home').with_target(DirectoryListingPage)
    end

    #MENU START
    def download_link
      webpage.link(:text, 'Download')
    end

    def license_link
      webpage.link(:text, 'License').with_target(LicensePage)
    end
#MENU END
  end
end