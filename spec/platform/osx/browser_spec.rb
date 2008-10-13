require 'spec/spec_helper'
require 'taza/browser'

describe "Taza::Browser with Safari Watir" do
  it "should be able to make a safari watir instance" do
    browser = nil
    begin
      browser = Taza::Browser.create({:browser => :safari, :driver => :watir})
      browser.should be_a_kind_of(Watir::Safari)
    ensure
      browser.close if browser.is_a?(Watir::Safari)
    end
  end
end
