module Taza
  class Flow
    attr_reader :site

    def initialize(site_instance)
      @site = site_instance
    end
  end
end
