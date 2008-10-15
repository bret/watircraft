Gem::Specification.new do |s|
  s.name = %q{safariwatir}
  s.version = "0.2.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dave Hoover"]
  s.date = %q{2008-10-09}
  s.description = %q{WATIR stands for "Web Application Testing in Ruby".  See WATIR project for more information.  This is a Safari-version of the original IE-only WATIR.}
  s.email = %q{dave@obtiva.com}
  s.files = ["safariwatir.rb", "safariwatir_script.rb", "safariwatir/core_ext.rb", "safariwatir/scripter.rb", "watir/exceptions.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://safariwatir.rubyforge.org/}
  s.require_paths = ["."]
  s.requirements = ["Mac OS X running Safari", "Some features require you to turn on \"Enable access for assistive devices\" in System Preferences > Universal Access"]
  s.rubyforge_project = %q{safariwatir}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Automated testing tool for web applications.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<rb-appscript>, [">= 0"])
    else
      s.add_dependency(%q<rb-appscript>, [">= 0"])
    end
  else
    s.add_dependency(%q<rb-appscript>, [">= 0"])
  end
end
