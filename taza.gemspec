# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{taza}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Anderson"]
  s.date = %q{2008-11-12}
  s.default_executable = %q{taza}
  s.description = %q{Taza is meant to make acceptance testing more sane for developers(or QA where applicable) and customers.}
  s.email = ["adamandersonis@gmail.com"]
  s.executables = ["taza"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/taza", "generators/flow/flow_generator.rb", "generators/flow/templates/flow.rb.erb", "generators/page/page_generator.rb", "generators/page/templates/functional_page_spec.rb.erb", "generators/page/templates/page.rb.erb", "generators/site/site_generator.rb", "generators/site/templates/site.rb.erb", "generators/site/templates/site.yml.erb", "lib/app_generators/taza/taza_generator.rb", "lib/app_generators/taza/templates/config.yml.erb", "lib/app_generators/taza/templates/rakefile.rb.erb", "lib/app_generators/taza/templates/spec_helper.rb.erb", "lib/taza.rb", "lib/taza/browser.rb", "lib/taza/browsers/ie_watir.rb", "lib/taza/browsers/safari_watir.rb", "lib/taza/flow.rb", "lib/taza/page.rb", "lib/taza/settings.rb", "lib/taza/site.rb", "lib/taza/tasks.rb", "spec/browser_spec.rb", "spec/flow_generator_spec.rb", "spec/page_generator_spec.rb", "spec/page_spec.rb", "spec/platform/osx/browser_spec.rb", "spec/platform/windows/browser_spec.rb", "spec/project_generator_spec.rb", "spec/sandbox/config.yml", "spec/sandbox/config/config.yml", "spec/sandbox/config/site_name.yml", "spec/sandbox/flows/batman.rb", "spec/sandbox/flows/robin.rb", "spec/sandbox/pages/foo/bar.rb", "spec/settings_spec.rb", "spec/site_generator_spec.rb", "spec/site_spec.rb", "spec/spec_helper.rb", "spec/taza_bin_spec.rb", "spec/taza_spec.rb", "spec/taza_tasks_spec.rb", "spec/unit_helper_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/scudco/taza/tree/master }
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{taza}
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Taza is meant to make acceptance testing more sane for developers(or QA where applicable) and customers.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<taglob>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<hoe>, [">= 0"])
      s.add_runtime_dependency(%q<mocha>, [">= 0.9.0"])
      s.add_runtime_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<rubigen>, [">= 0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<taglob>, [">= 1.0.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0.9.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rubigen>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<taglob>, [">= 1.0.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0.9.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rubigen>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end
