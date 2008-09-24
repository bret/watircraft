# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/taza.rb'
require 'spec/rake/spectask'

Hoe.new('ftw', Ftw::VERSION) do |p|
  p.rubyforge_name = 'ftw' # if different than lowercase project name
  p.developer('FIX', 'FIX@example.com')
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end 

# vim: syntax=Ruby
