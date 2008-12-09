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
    
    def has_fixture_file?(fixture)
      @fixtures.keys.include?(fixture)
    end
    
    def fixtures_pattern
      File.join(base_path, 'fixtures','*.yml')
    end

    def base_path
      File.join('.','spec')
    end
  end

  module Fixture_methods
    def method_missing(method, *args)
      fixture = Fixture.new
      fixture.load_all
      if fixture.has_fixture_file?(method)
        fixture.fixtures(method)[args.first.to_s]
      else
        super
      end
    end
  end

end
