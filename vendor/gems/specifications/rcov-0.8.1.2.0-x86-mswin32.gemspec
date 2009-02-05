Gem::Specification.new do |s|
  s.name = %q{rcov}
  s.version = "0.8.1.2.0"
  s.platform = %q{mswin32}

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Mauricio Fernandez"]
  s.cert_chain = nil
  s.date = %q{2007-11-21}
  s.default_executable = %q{rcov}
  s.description = %q{rcov is a code coverage tool for Ruby. It is commonly used for viewing overall test unit coverage of target code.  It features fast execution (20-300 times faster than previous tools), multiple analysis modes, XHTML and several kinds of text reports, easy automation with Rake via a RcovTask, fairly accurate coverage information through code linkage inference using simple heuristics, colorblind-friendliness...}
  s.email = %q{mfp@acm.org}
  s.executables = ["rcov"]
  s.extra_rdoc_files = ["README.API", "README.rake", "README.rant", "README.vim"]
  s.files = ["bin/rcov", "lib/rcov.rb", "lib/rcov/lowlevel.rb", "lib/rcov/version.rb", "lib/rcov/rant.rb", "lib/rcov/report.rb", "lib/rcov/rcovtask.rb", "ext/rcovrt/extconf.rb", "ext/rcovrt/rcovrt.c", "ext/rcovrt/callsite.c", "LEGAL", "LICENSE", "Rakefile", "Rantfile", "README.rake", "README.rant", "README.emacs", "README.en", "README.vim", "README.API", "THANKS", "test/test_functional.rb", "test/test_FileStatistics.rb", "test/sample_03.rb", "test/sample_05-new.rb", "test/test_CodeCoverageAnalyzer.rb", "test/sample_04.rb", "test/sample_02.rb", "test/sample_05-old.rb", "test/sample_01.rb", "test/turn_off_rcovrt.rb", "test/test_CallSiteAnalyzer.rb", "test/sample_05.rb", "mingw-rbconfig.rb", "rcov.vim", "rcov.el", "setup.rb", "BLURB", "CHANGES", "lib/rcovrt.so"]
  s.has_rdoc = true
  s.homepage = %q{http://eigenclass.org/hiki.rb?rcov}
  s.rdoc_options = ["--main", "README.API", "--title", "rcov code coverage tool"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Code coverage analysis tool for Ruby}
  s.test_files = ["test/test_functional.rb", "test/test_FileStatistics.rb", "test/test_CodeCoverageAnalyzer.rb", "test/test_CallSiteAnalyzer.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if current_version >= 3 then
    else
    end
  else
  end
end
