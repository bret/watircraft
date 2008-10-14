Gem::Specification.new do |s|
  s.name = %q{Selenium}
  s.version = "1.1.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shane Duan"]
  s.autorequire = %q{selenium}
  s.date = %q{2008-07-17}
  s.default_executable = %q{selenium}
  s.email = %q{selenium-ruby@googlegroups.com}
  s.executables = ["selenium"]
  s.extra_rdoc_files = ["README"]
  s.files = ["bin/selenium", "lib/selenium", "lib/selenium/alert.rb", "lib/selenium/autoit", "lib/selenium/autoit/AutoItX3.dll", "lib/selenium/autoit/README", "lib/selenium/auto_it.rb", "lib/selenium/auto_it_driver.rb", "lib/selenium/auto_it_window.rb", "lib/selenium/button.rb", "lib/selenium/file_upload.rb", "lib/selenium/html_element.rb", "lib/selenium/key.rb", "lib/selenium/link.rb", "lib/selenium/openqa", "lib/selenium/openqa/README", "lib/selenium/openqa/selenium-server.jar.txt", "lib/selenium/openqa/selenium.rb", "lib/selenium/openqa/sslSupport", "lib/selenium/openqa/sslSupport/cybervillainsCA.cer", "lib/selenium/selenium_server.rb", "lib/selenium/server.rb", "lib/selenium/server_manager.rb", "lib/selenium/text_area.rb", "lib/selenium/text_field.rb", "lib/selenium/version", "lib/selenium/web_page.rb", "lib/selenium.rb", "spec/selenium", "spec/selenium/examples", "spec/selenium/examples/selenium_ruby", "spec/selenium/examples/selenium_ruby/directory_listing_page.rb", "spec/selenium/examples/selenium_ruby/download_page.rb", "spec/selenium/examples/selenium_ruby/home_page.rb", "spec/selenium/examples/selenium_ruby/license_page.rb", "spec/selenium/examples/selenium_ruby/menu.rb", "spec/selenium/examples/selenium_ruby/selenium_ruby_page.rb", "spec/selenium/examples/selenium_ruby.rb", "spec/selenium/manual_tc_file_upload.rb", "spec/selenium/manual_tc_timout.rb", "spec/selenium/screenshot.png", "spec/selenium/selenium.rb", "spec/selenium/tc_auto_it.rb", "spec/selenium/tc_auto_it_window.rb", "spec/selenium/tc_basic_operation.rb", "spec/selenium/tc_domain_example.rb", "spec/selenium/tc_html_element.rb", "spec/selenium/tc_interaction_example.rb", "spec/selenium/tc_server.rb", "spec/selenium/tc_web_page.rb", "spec/ts_selenium.rb", "README"]
  s.has_rdoc = true
  s.homepage = %q{http://selenium.rubyforge.org/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{selenium}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A project that wraps selenium API into object-oriented testing style and packages it into a RubyGem.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
