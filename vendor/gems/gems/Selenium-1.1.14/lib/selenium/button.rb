module Selenium
  class Button < HtmlElement
    def initialize(webpage, locator)
      super(webpage, locator)
    end
  end
end