Gem::Specification.new do |s|
  s.name = %q{jscruggs-metric_fu}
  s.version = "0.7.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jake Scruggs", "Sean Soper"]
  s.date = %q{2008-08-13}
  s.description = %q{Gives you a fist full of code metrics}
  s.email = %q{jake.scruggs@gmail.com}
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README"]
  s.files = ["History.txt", "Manifest.txt", "metric_fu.gemspec", "MIT-LICENSE", "README", "TODO.txt", "lib/metric_fu", "lib/metric_fu/flog_reporter", "lib/metric_fu/flog_reporter/base.rb", "lib/metric_fu/flog_reporter/flog_reporter.css", "lib/metric_fu/flog_reporter/generator.rb", "lib/metric_fu/flog_reporter/operator.rb", "lib/metric_fu/flog_reporter/page.rb", "lib/metric_fu/flog_reporter/scanned_method.rb", "lib/metric_fu/flog_reporter.rb", "lib/metric_fu/md5_tracker.rb", "lib/metric_fu/saikuro", "lib/metric_fu/saikuro/saikuro.rb", "lib/metric_fu/saikuro/SAIKURO_README", "lib/metric_fu.rb", "lib/tasks", "lib/tasks/churn.rake", "lib/tasks/coverage.rake", "lib/tasks/flog.rake", "lib/tasks/metric_fu.rake", "lib/tasks/metric_fu.rb", "lib/tasks/saikuro.rake", "lib/tasks/stats.rake", "test/test_helper.rb", "test/test_md5_tracker.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://metric-fu.rubyforge.org/}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Generates project metrics using Flog, RCov, Saikuro and more}
  s.test_files = ["test/test_md5_tracker.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<flog>, ["> 0.0.0"])
      s.add_runtime_dependency(%q<rcov>, ["> 0.0.0"])
    else
      s.add_dependency(%q<flog>, ["> 0.0.0"])
      s.add_dependency(%q<rcov>, ["> 0.0.0"])
    end
  else
    s.add_dependency(%q<flog>, ["> 0.0.0"])
    s.add_dependency(%q<rcov>, ["> 0.0.0"])
  end
end
