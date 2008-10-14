module Selenium
  class Alert
    def initialize(webpage)
      @webpage = webpage
    end

    def present?
      @webpage.alert_present?
    end

    def message
      @webpage.alert_message
    end
  end
end