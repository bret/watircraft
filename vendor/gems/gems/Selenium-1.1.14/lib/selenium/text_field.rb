module Selenium
class TextField < HtmlElement
  
  def initialize(webpage, locator)
    super(webpage, locator)
  end
  
  def enter(value)
    @webpage.enter(locator, value)
  end
  
  def value
    @webpage.value(locator)
  end
end
end