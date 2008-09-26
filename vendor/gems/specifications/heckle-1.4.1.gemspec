Gem::Specification.new do |s|
  s.name = %q{heckle}
  s.version = "1.4.1"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Davis"]
  s.cert_chain = nil
  s.date = %q{2007-06-05}
  s.default_executable = %q{heckle}
  s.description = %q{Heckle is a mutation tester. It modifies your code and runs your tests to make sure they fail. The idea is that if code can be changed and your tests don't notice, either that code isn't being covered or it doesn't do anything.}
  s.email = %q{ryand-ruby@zenspider.com}
  s.executables = ["heckle"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/heckle", "lib/heckle.rb", "lib/test_unit_heckler.rb", "sample/Rakefile", "sample/changes.log", "sample/lib/heckled.rb", "sample/test/test_heckled.rb", "test/fixtures/heckled.rb", "test/test_heckle.rb"]
  s.has_rdoc = true
  s.homepage = %q{    http://www.rubyforge.org/projects/seattlerb}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{seattlerb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Unit Test Sadism}
  s.test_files = ["test/test_heckle.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if current_version >= 3 then
      s.add_runtime_dependency(%q<ruby2ruby>, [">= 1.1.0"])
      s.add_runtime_dependency(%q<ZenTest>, [">= 3.5.2"])
      s.add_runtime_dependency(%q<hoe>, [">= 1.2.1"])
    else
      s.add_dependency(%q<ruby2ruby>, [">= 1.1.0"])
      s.add_dependency(%q<ZenTest>, [">= 3.5.2"])
      s.add_dependency(%q<hoe>, [">= 1.2.1"])
    end
  else
    s.add_dependency(%q<ruby2ruby>, [">= 1.1.0"])
    s.add_dependency(%q<ZenTest>, [">= 3.5.2"])
    s.add_dependency(%q<hoe>, [">= 1.2.1"])
  end
end
