= taglob

== DESCRIPTION:

tags + Dir.glob = Dir.taglob

http://github.com/scudco/taglob/tree/master

== FEATURES/PROBLEMS:

* easily select tagged Ruby files
* rake tasks for test::unit and rspec
* rake task for checking against a valid list of tags
* can AND or OR tags

== SYNOPSIS:


Taglob is great. Check this out.
Imagine a bunch of files that look like
  #tags: zomg,buttz,foo,important
  class Lol
    def lulz
      puts "here are your lulz, sir"
    end
  end

And then you are like dang I wish I could glob these files based on the 
tags I setup! What am I doing with my life???
Taglob! (like Tada! but more like its unsophisticated country cousin(in name only(parentheses)))
  Dir.taglob("**/*.rb","foo","lol")
That will totally give you back all the files tagged with 'foo' and 'lol' in an array of strings representing the paths of those files.
It is really just glob with some extra stuff thrown in.
Totally small, totally useless, totally taglob.

  require 'rubygems'
  require 'taglob'
  
  Dir.taglob('**/*.rb','foo','bar','buttz').each {|file| puts "#{file} was tagged with foo or bar or buttz!"}

On a more serious note:
  * Dir.taglob('**/*.rb','tags,for,the,win') <- Will produce an array of files that contain all these tags(AND)
  * Dir.taglob('**/*.rb','tags|or|the|win') <- Will produce an array of files that contain any of these tags(OR)
  * rake spec SPEC_OPTS='-f specdoc' <- More infroz(this obviously needs to be run from the gem directory :P)
  * taglob binary!
    * $ taglob <dirname> <- produces a list of files in <dirname> with their respective tags
    * $ taglob <file> <- produces a list of tags for that file
  * Rake tasks!
    * You can now require 'taglob/rake/tasks' in your Rakefile to get test_tag and spec_tag tasks that would be used like this:
      * $ rake spec_tag tags="for,the,win"
      * $ rake test_tag tags="foo|bar"
    * You can also specify your own TestTagTasks in your Rakefile:
      require 'taglob/rake'

      Taglob::Rake::SpecTagsTask.new :spec_regression do |t|
        t.pattern = 'spec/**/*.rb'
        t.tags = "regression|smoke"
      end
      Taglob::Rake::TestTagsTask.new :test_regression do |t|
        t.pattern = 'test/**/*.rb'
        t.tags = "regression|smoke"
      end
    * CheckTagsTask will check all tags in a glob pattern against a valid list of tags
      require 'taglob/rake'
      task = Taglob::Rake::CheckTagsTask.new do |t|
        t.pattern = 'spec/**/*.rb'
        t.valid_tag_source = 'config/valid_tags.txt'
      end


== INSTALL:

* sudo gem install taglob

== UNINSTALL:

* sudo gem uninstall taglob

== REINSTALL

* sudo gem install taglob

== LICENSE:

The copyrights-are-an-imaginary-construct license.
