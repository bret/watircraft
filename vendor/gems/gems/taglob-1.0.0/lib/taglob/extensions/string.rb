class String
  def tags
    self =~ /^# ?tags:\s+(.*)/ ? $1.split(',').map {|tag| tag.strip} : []
  end
end
