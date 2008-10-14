$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium/auto_it'
require 'lib/selenium'
require 'spec'

module Selenium
  describe FileUpload do
    before(:all) do
      @server = Server.on_port(4440)
#      @server.print_log = true
      @server.start
    end

    after(:all) do
      @server.stop
    end

    before do
#      @page = @server.open('*iexplore', 'http://www.rubyforge.org/projects/selenium')
      @page = @server.open('*chrome D:\Program Files\Mozilla Firefox2\firefox.exe', 'http://www.rubyforge.org/projects/selenium')
    end

    after do
      file = File.join(File.dirname(__FILE__), 'screenshot.png')
      puts "image at #{file}"
      @page.capture_screen(file)
      @page.close
    end

    # this requires the user to manually enter the login information on rubyforge, and can only be run by selenium admin
    it 'should handle firefox' do
      login_link = @page.link(:text, 'Log In')
      autoit = AutoIt.load
      login_link.click if login_link.present?
      AutoItWindow.wait_for(autoit, 'Website Certified by an Unknown Authority').send_keys(' ')
      @page.wait_for_load
      @page.wait_until('manual login for test') do |message|
        puts message
        not login_link.present?
      end
      @page.wait_for_load
      selenium_project_link = @page.link(:text, 'Selenium')
      selenium_project_link.should be_present
      selenium_project_link.click_wait
      @page.link(:text, 'Files').click_wait
      @page.link(:href, '/frs/admin/?group_id=2789').click_wait
      @page.link(:xpath, "//a[@href='qrs.php?package_id=3298&group_id=2789']").click_wait
      @page.file_upload(:name, 'userfile').enter("file:///#{__FILE__}")
#      @page.file_upload('userfile').enter("file:///#{__FILE__}")
    end
  end
end