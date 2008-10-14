module Selenium

  # Link class that models the behavior of a link
  class Link < HtmlElement
    def Link::by_id(browser, id, target = nil)
      Link.new(WebPage.new(browser), "id=#{id}", target)
    end

    def Link::by_text(browser, text, target = nil)
      Link.new(WebPage.new(browser), "link=#{text}", target)
    end

    def initialize(webpage, locator, target = nil)
      super(webpage, locator)
      @target = target
    end

    def with_target(target)
      Link.new(webpage, locator, target.new(webpage.browser))
    end

    # click the link, wait for the page to load, and asserts the target that
    # was passed in during initialization
    def go
      raise "target page not defined for link #{@locator}" unless @target
      click_wait
      @target.ensure_present
      @target
    end
  end
end
