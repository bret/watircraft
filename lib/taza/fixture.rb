module Taza
  class Fixture
    
    def initialize
      @fixtures = {}
    end
    
    def load_all
      Dir.glob(fixtures_pattern) do |file|
        entitized_fixture = {}
        YAML.load_file(file).each do |key, value|
          entitized_fixture[key] = Entity.new(value)
        end
        @fixtures[File.basename(file,'.yml').to_sym] = entitized_fixture
      end
    end
    
    def fixtures(fixture)
      @fixtures[fixture]
    end
    
    def fixtures_pattern
      base_path + '/fixtures/*.yml'
    end
    
    #todo unit and 
    def base_path
      '.'
    end
  end  
end