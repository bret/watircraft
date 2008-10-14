$:.unshift(File.dirname(__FILE__))

require 'selenium'

module Selenium
  describe HtmlElement do
    before(:all) do
      @server = Server.new(4445)
      @server.start
      @webpage = @server.open(BROWSER, 'http://localhost:2000/test/index.html')
    end

    before do
      @webpage.open_page('/test/index.html')
    end

    after(:all) do
      @webpage.close if @webpage
      @server.stop
    end

    it 'should support double click and key press' do
      text_area = @webpage.text_area(:name, 'doubleclick')
      text_area.enter 'html double click'
      text_area.double_click
      @webpage.alert.should be_present
      @webpage.alert.message.should == 'double clicked with value html double click'
      text_area.key_press('b')
      text_area.value.should == 'html double clickb'
    end
  end
end