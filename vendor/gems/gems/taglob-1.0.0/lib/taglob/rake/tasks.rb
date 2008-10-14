require 'taglob/rake/test_tags_task'

Taglob::Rake::TestTagsTask.new do |t|
  t.pattern = 'test/**/test_*.rb'
  t.tags = ENV['tags']
end

Taglob::Rake::SpecTagsTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.tags = ENV['tags']
end
