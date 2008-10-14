module Selenium
  class HtmlElement
    attr_reader :webpage, :locator
    def initialize(webpage, locator)
      webpage = WebPage.new(webpage) if webpage.is_a? SeleniumDriver
      @webpage = webpage
      @locator = locator
    end

    def browser
      webpage.browser
    end

    def text
      @webpage.text(@locator)
    end

    def present?
      @webpage.element_present? @locator
    end

    # click the element
    def click
      @webpage.click(@locator)
    end

    # click the element and wait for page to load
    # TODO: wait on block instead if givven
    def click_wait
      @webpage.click_wait(@locator)
    end

    def double_click
      @webpage.double_click(@locator)
    end

    def key_press(key)
      @webpage.key_press(@locator, key)
    end

  end
end