class File
  def self.tags(file)
    parsed_tags = []
    File.readlines(file).each do |line|
      parsed_tags = parsed_tags | self.parse_tags(line)
    end
    parsed_tags
  end

  def self.parse_tags(line)
    line =~ /^# ?tags:\s+(.*)/ ? $1.split(',').map {|tag| tag.strip} : []
  end
end