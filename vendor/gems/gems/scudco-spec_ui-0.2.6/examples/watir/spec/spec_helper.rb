# You don't need to tweak the $LOAD_PATH if you have Spec::Ui installed as gems
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../../lib')

require 'rubygems'
require 'spec'
require 'spec/ui'
require 'spec/ui/watir'

if RUBY_PLATFORM =~ /darwin/
  require 'safariwatir'
  Watir::Browser = Watir::Safari
elsif RUBY_PLATFORM =~ /linux/
  require 'firewatir'
  Watir = FireWatir
  Watir::Browser = FireWatir::Firefox
else
  require 'watir'
  Watir::Browser = Watir::IE
end

Spec::Runner.configure do |config|
  config.before(:all) do
    @browser = Watir::Browser.new
  end

  config.after(:each) do
    Spec::Ui::ScreenshotFormatter.instance.take_screenshot_of(@browser)
  end

  config.after(:all) do
    @browser.close
    sleep 5.5 # WTF apple throws an OS 609 Error unless we sleep for some arbitrary(okay maybe not) time
  end
end
