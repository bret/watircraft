$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'spec'
require 'lib/selenium'

module Selenium
  BROWSER = '*chrome D:\Program Files\Mozilla Firefox2\firefox.exe'
end