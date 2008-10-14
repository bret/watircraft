require "spec"

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'selenium'

describe 'Time Out Control' do

  before(:each) do
  end

  after(:each) do
  end


  it "should honor the time out argument" do
     link_list=["http://www.myantel.net.mm",
               "http://www.khitlunge.net.mm",
               "http://www.mrtv4.net.mm",
               "http://www.mpt.net.mm",
               "http://www.yatanarponteleport.net.mm",
               "http://www.net.mm",
               "http://www.mwdtv.net.mm",
               "http://ns1.net.mm",
               "http://www.isy.net.mm",
               "http://www.mptmail.net.mm",
               "http://www.mrtv3.net.mm"

     ]

     selenium=Selenium::SeleniumDriver.new("localhost",4444,"*chrome", link_list.first, 600000)
     selenium.start
     selenium.set_timeout(600000)
     link_list.each {|url| selenium.open(url) }
  end

end
