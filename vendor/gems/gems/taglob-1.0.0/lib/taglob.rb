# Taglob is great. Check this out.
# Imagine a bunch of files that look like
#  #tags: zomg,buttz,foo,important
#  class Lol
#    def lulz
#      puts "here are your lulz, sir"
#    end
#  end
#
# And then you are like dang I wish I could glob these files based on the
# tags I setup! What am I doing with my life???
# Taglob! (like Tada! but more like its unsophisticated country cousin(in name only(parentheses)))
#  Dir.taglob("**/*.rb","foo","lol")
# That will totally give you back all the files tagged with 'foo' and 'lol' in an array of strings representing the paths of those files.
# It is really just glob with some extra stuff thrown in.
# Totally small, totally useless, totally taglob.

require 'taglob/extensions'

module Taglob
  VERSION = '1.0.0'
  
  def self.invalid_tags(pattern,valid_tags)
    invalids = {}
    Dir.tags(pattern).each do |file, tags|
      invalid_tags = tags - valid_tags
      invalids.merge!({file => invalid_tags}) if !invalid_tags.empty?
    end
    invalids
  end
end
