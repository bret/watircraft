module Taza
  class Fixture

    def initialize
      @fixtures = {}
    end

    def load_all
      Dir.glob(fixtures_pattern) do |file|
        entitized_fixture = {}
        YAML.load_file(file).each do |key, value|
          entitized_fixture[key] = value.convert_hash_keys_to_methods(self)
        end
        @fixtures[File.basename(file,'.yml').to_sym] = entitized_fixture
      end
    end

    def get_fixture_entity(singular_fixture_file_key,entity_key)
      @fixtures[singular_fixture_file_key.pluralize_to_sym][entity_key]
    end

    def pluralized_fixture_exists?(singularized_fixture_name)
      has_fixture_file?(singularized_fixture_name.pluralize_to_sym)
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
        fixture.get_fixture_entity(method.to_s,args.first.to_s)
      else
        super
      end
    end
  end

end
