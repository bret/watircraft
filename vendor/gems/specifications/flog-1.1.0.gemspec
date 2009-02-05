Gem::Specification.new do |s|
  s.name = %q{flog}
  s.version = "1.1.0"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Davis"]
  s.cert_chain = nil
  s.date = %q{2007-08-21}
  s.default_executable = %q{flog}
  s.description = %q{Flog reports the most tortured code in an easy to read pain report. The higher the score, the more pain the code is in.  % ./bin/flog bin/flog Total score = 128.7  Flog#report: (21) 4: puts 2: sort_by ...}
  s.email = %q{ryand-ruby@zenspider.com}
  s.executables = ["flog"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/flog", "lib/flog.rb", "unpack.rb", "update_scores.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://ruby.sadi.st/}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{seattlerb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Flog reports the most tortured code in an easy to read pain report. The higher the score, the more pain the code is in.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if current_version >= 3 then
      s.add_runtime_dependency(%q<ParseTree>, [">= 2.0.0"])
      s.add_runtime_dependency(%q<hoe>, [">= 1.3.0"])
    else
      s.add_dependency(%q<ParseTree>, [">= 2.0.0"])
      s.add_dependency(%q<hoe>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<ParseTree>, [">= 2.0.0"])
    s.add_dependency(%q<hoe>, [">= 1.3.0"])
  end
end
