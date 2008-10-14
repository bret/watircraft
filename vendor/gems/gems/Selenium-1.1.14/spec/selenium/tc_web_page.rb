require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium'

module Selenium
  describe WebPage do
    before(:all) do
      @server = Server.new(2344)
      @server.start
      @@webpage = nil
    end

    before do
      @@webpage.open_page('/') if @@webpage
    end

    after(:all) do
      @server.stop
    end

    def webpage
      @@webpage = @server.open('*chrome D:\Program Files\Mozilla Firefox2\firefox.exe', 'http://localhost:2000/') unless @@webpage
      @@webpage
    end

    it 'should have meaningful to_s support' do
      webpage = WebPage.new(SeleniumDriver.new('localhost', 2222, '*chrome', 'http://www.example.com', 60000), 'expected title')
      webpage.to_s.should == 'Selenium::WebPage(\'expected title\') - SeleniumDriver'
    end

    it 'should create link based on text' do
      webpage = WebPage.new('browser')
      webpage.link(:text, 'text').locator.should == 'link=text'
    end

    it 'should create link based on href' do
      webpage = WebPage.new('browser')
      webpage.link(:href, 'a.html').locator.should == "xpath=//a[@href='a.html']"
    end

    it 'should convert how and what to locator for selenium driver' do
      webpage.element_locator('name').should == 'name'
      webpage.element_locator(:id, 'id').should == 'id=id'
      webpage.element_locator(:name, 'name').should == 'name=name'
      webpage.element_locator(:xpath, '//a').should == 'xpath=//a'
    end

    it 'should support elements by passing in name directly' do
      webpage.open_page('/test/index.html')
      text_field = webpage.text_field('doubleclick')
      text_field.locator.should == 'doubleclick'
      text_field.enter('webpage')
      webpage.text_area('doubleclick').enter('webpage')
      webpage.text_area('doubleclick').double_click
      webpage.should be_alert_present
      webpage.alert_message.should == 'double clicked with value webpage'
      webpage.text_area('doubleclick').key_press('a')
      webpage.text_area('doubleclick').value.should == 'webpagea'
    end

    it 'should support double click and key press' do
      webpage.open_page('/test/index.html')
      webpage.enter('doubleclick', 'webpage')
      webpage.double_click('doubleclick')
      webpage.should be_alert_present
      webpage.alert_message.should == 'double clicked with value webpage'
      webpage.key_press('doubleclick', 'a')
      webpage.value('doubleclick').should == 'webpagea'
    end

    it 'should support context menu' do
      webpage.open_page('/test/index.html')
      webpage.context_menu('link=License')
      webpage.capture_screen(File.join(File.dirname(__FILE__), 'screenshot.png'))
    end

    it 'should support focus event and fire blur event' do
      webpage.open_page('/test/index.html')
      webpage.focus('events')
      webpage.enter('events', 'value')
      webpage.value('events').should == 'value'
      webpage.fire_event('events', 'blur')
      webpage.should be_alert_present
      webpage.alert_message.should == 'blurred with value value'
      webpage.fire_event('events', 'focus')
#      webpage.focus('events')
      webpage.value('events').should == 'default'
    end

    it 'should support key event and check if it is supported' do
      webpage.open_page('/test/index.httml')
      webpage.key_down(:shift)
      webpage.key_up(:shift)
      [:shift, :meta, :alt, :control].each do |key|
        key = webpage.key(key)
        key.down
        key.up
      end
      webpage.key(:alt).down

      Proc.new {webpage.key_up(:command)}.should raise_error(NoKeyError)
      Proc.new {webpage.key_down(:command)}.should raise_error(NoKeyError)
    end

    it 'should have speed as attribute' do
      webpage.speed = 500
      webpage.speed.should == 500
    end

  end
end
