# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{watircraft}
  s.version = "0.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bret Pettichord", "Jim Matthews", "Charley Baker", "Adam Anderson"]
  s.date = %q{2009-04-03}
  s.default_executable = %q{watircraft}
  s.description = %q{WatirCraft is a framework for testing web apps.}
  s.email = %q{bret@pettichord.com}
  s.executables = ["watircraft"]
  s.extra_rdoc_files = ["History.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "VERSION.yml", "watircraft.gemspec", "bin/watircraft", "lib/extensions", "lib/extensions/array.rb", "lib/extensions/hash.rb", "lib/extensions/object.rb", "lib/extensions/string.rb", "lib/extensions/watir.rb", "lib/taza", "lib/taza/browser.rb", "lib/taza/entity.rb", "lib/taza/fixture.rb", "lib/taza/flow.rb", "lib/taza/page.rb", "lib/taza/settings.rb", "lib/taza/site.rb", "lib/taza/tasks.rb", "lib/taza.rb", "lib/watircraft", "lib/watircraft/generator_helper.rb", "lib/watircraft/table.rb", "lib/watircraft/version.rb", "lib/watircraft.rb", "spec/array_spec.rb", "spec/browser_spec.rb", "spec/entity_spec.rb", "spec/fake_table.rb", "spec/fixtures_spec.rb", "spec/fixture_spec.rb", "spec/hash_spec.rb", "spec/object_spec.rb", "spec/page_generator_spec.rb", "spec/page_spec.rb", "spec/project_generator_spec.rb", "spec/sandbox", "spec/sandbox/config", "spec/sandbox/config/config.yml", "spec/sandbox/config/environments.yml", "spec/sandbox/config/simpler.yml", "spec/sandbox/config/simpler_site.yml", "spec/sandbox/config.yml", "spec/sandbox/fixtures", "spec/sandbox/fixtures/examples.yml", "spec/sandbox/fixtures/users.yml", "spec/sandbox/flows", "spec/sandbox/flows/batman.rb", "spec/sandbox/flows/robin.rb", "spec/sandbox/pages", "spec/sandbox/pages/foo", "spec/sandbox/pages/foo/bar_page.rb", "spec/sandbox/pages/foo/partials", "spec/sandbox/pages/foo/partials/partial_the_reckoning.rb", "spec/settings_spec.rb", "spec/site_spec.rb", "spec/spec_generator_helper.rb", "spec/spec_generator_spec.rb", "spec/spec_helper.rb", "spec/steps_generator_spec.rb", "spec/string_spec.rb", "spec/table_spec.rb", "spec/taza_spec.rb", "spec/watircraft_bin_spec.rb", "spec/watir_spec.rb", "app_generators/watircraft", "app_generators/watircraft/templates", "app_generators/watircraft/templates/config.yml.erb", "app_generators/watircraft/templates/environments.yml.erb", "app_generators/watircraft/templates/feature_helper.rb", "app_generators/watircraft/templates/initialize.rb.erb", "app_generators/watircraft/templates/rakefile.rb", "app_generators/watircraft/templates/readme.txt", "app_generators/watircraft/templates/script", "app_generators/watircraft/templates/script/console", "app_generators/watircraft/templates/script/console.cmd", "app_generators/watircraft/templates/site.rb.erb", "app_generators/watircraft/templates/site_start.rb.erb", "app_generators/watircraft/templates/spec_helper.rb", "app_generators/watircraft/templates/spec_initialize.rb", "app_generators/watircraft/templates/world.rb", "app_generators/watircraft/USAGE", "app_generators/watircraft/watircraft_generator.rb", "watircraft_generators/page", "watircraft_generators/page/page_generator.rb", "watircraft_generators/page/templates", "watircraft_generators/page/templates/page.rb.erb", "watircraft_generators/page/USAGE", "watircraft_generators/spec", "watircraft_generators/spec/spec_generator.rb", "watircraft_generators/spec/templates", "watircraft_generators/spec/templates/spec.rb.erb", "watircraft_generators/spec/USAGE", "watircraft_generators/steps", "watircraft_generators/steps/steps_generator.rb", "watircraft_generators/steps/templates", "watircraft_generators/steps/templates/steps.rb.erb", "watircraft_generators/steps/USAGE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bret/watircraft/tree/master}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{watir}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{WatirCraft is a framework for testing web apps.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<taglob>, [">= 1.1.1"])
      s.add_runtime_dependency(%q<rake>, [">= 0.8.3"])
      s.add_runtime_dependency(%q<mocha>, [">= 0.9.3"])
      s.add_runtime_dependency(%q<rubigen>, [">= 1.4.0"])
      s.add_runtime_dependency(%q<rspec>, ["= 1.1.12"])
      s.add_runtime_dependency(%q<cucumber>, ["= 0.1.16"])
    else
      s.add_dependency(%q<taglob>, [">= 1.1.1"])
      s.add_dependency(%q<rake>, [">= 0.8.3"])
      s.add_dependency(%q<mocha>, [">= 0.9.3"])
      s.add_dependency(%q<rubigen>, [">= 1.4.0"])
      s.add_dependency(%q<rspec>, ["= 1.1.12"])
      s.add_dependency(%q<cucumber>, ["= 0.1.16"])
    end
  else
    s.add_dependency(%q<taglob>, [">= 1.1.1"])
    s.add_dependency(%q<rake>, [">= 0.8.3"])
    s.add_dependency(%q<mocha>, [">= 0.9.3"])
    s.add_dependency(%q<rubigen>, [">= 1.4.0"])
    s.add_dependency(%q<rspec>, ["= 1.1.12"])
    s.add_dependency(%q<cucumber>, ["= 0.1.16"])
  end
end
