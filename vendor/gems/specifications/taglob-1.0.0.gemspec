Gem::Specification.new do |s|
  s.name = %q{taglob}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Anderson"]
  s.date = %q{2008-10-11}
  s.default_executable = %q{taglob}
  s.description = %q{Tagging for Ruby files}
  s.email = %q{adamandersonis@gmail.com}
  s.executables = ["taglob"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "spec/missing_tags.txt", "spec/valid_tags.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/taglob", "lib/taglob.rb", "lib/taglob/extensions.rb", "lib/taglob/extensions/dir.rb", "lib/taglob/extensions/file.rb", "lib/taglob/extensions/string.rb", "lib/taglob/rake.rb", "lib/taglob/rake/check_tags_task.rb", "lib/taglob/rake/tasks.rb", "lib/taglob/rake/test_tags_task.rb", "spec/check_tags_task_spec.rb", "spec/dir_tagor_spec.rb", "spec/missing_tags.txt", "spec/spec_helper.rb", "spec/tagged_files/epic_lulz.rb", "spec/tagged_files/foo.rb", "spec/tagged_files/foo_bar_buttz.rb", "spec/taglob_spec.rb", "spec/tasks_spec.rb", "spec/test_tags_task_spec.rb", "spec/valid_tags.txt"]
  s.has_rdoc = true
  s.homepage = %q{http://taglob.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{taglob}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Dir.taglob selects tagged Ruby files}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
