class Dir

  def self.tags(pattern)
    files = {}
    Dir.glob(pattern).each do |file|
      tags = File.tags(file)
      files.merge!({file => tags}) unless tags.empty?
    end
    files
  end

  def self.taglob(pattern,tags)
    if(tags.include?('|'))
      Dir.tag_or(pattern,*tags.split('|'))      
    else
      Dir.tag_and(pattern,*tags.split(','))      
    end
  end

  def self.tag_and(pattern, *tags)
    tagged_files = []
    self.tags(pattern).each do |file,parsed_tags|
      tagged_files << file if (tags - parsed_tags).empty?
    end
    tagged_files
  end
  
  def self.tag_or(pattern, *tags)
    tagged_files = []
    self.tags(pattern).each do |file,parsed_tags|
      tagged_files << file if !(tags & parsed_tags).empty?
    end
    tagged_files
  end

end
