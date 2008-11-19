Gem::Specification.new do |s|
  s.name = %q{scudco-spec_ui}
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aslak Hellesoy"]
  s.date = %q{2008-11-11}
  s.description = %q{Run RSpec with UI testing tools}
  s.email = %q{aslak.hellesoy@gmail.com}
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "examples/selenium/README.txt", "examples/watir/README.txt"]
  s.files = ["TODO", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "examples/selenium/README.txt", "examples/selenium/Rakefile", "examples/selenium/spec/selenium/find_rspecs_homepage_spec.rb", "examples/selenium/spec/spec_helper.rb", "examples/watir/README.txt", "examples/watir/Rakefile", "examples/watir/spec/spec_helper.rb", "examples/watir/spec/watir/find_rspecs_homepage_spec.rb", "lib/spec/ui.rb", "lib/spec/ui/formatter.rb", "lib/spec/ui/images/rmagick_not_installed.png", "lib/spec/ui/images/win32screenshot_not_installed.png", "lib/spec/ui/images/wrong_win32screenshot.png", "lib/spec/ui/screenshot_saver.rb", "lib/spec/ui/selenium.rb", "lib/spec/ui/selenium/driver_ext.rb", "lib/spec/ui/version.rb", "lib/spec/ui/watir.rb", "lib/spec/ui/watir/browser.rb", "lib/spec/ui/watir/matchers.rb", "lib/spec/ui/watir/watir_behaviour.rb", "spec/spec.opts", "spec/spec/ui/watir/matchers_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://rspec-ext.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rspec-ext}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Run RSpec with UI testing tools}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<rspec>, [">= 1.0.8"])
      s.add_runtime_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<rspec>, [">= 1.0.8"])
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.0.8"])
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end
