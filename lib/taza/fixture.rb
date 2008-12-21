module Taza
  class Fixture # :nodoc:

    def initialize # :nodoc:
      @fixtures = {}
    end

    def load_all # :nodoc:
      Dir.glob(fixtures_pattern) do |file|
        entitized_fixture = {}
        YAML.load_file(file).each do |key, value|
          entitized_fixture[key] = value.convert_hash_keys_to_methods(self)
        end
        @fixtures[File.basename(file,'.yml').to_sym] = entitized_fixture
      end
    end
    
    def fixture_names # :nodoc:
      @fixtures.keys
    end
    
    def get_fixture_entity(fixture_file_key,entity_key) # :nodoc:
      @fixtures[fixture_file_key][entity_key]
    end

    def pluralized_fixture_exists?(singularized_fixture_name) # :nodoc:
      fixture_names.include?(singularized_fixture_name.pluralize_to_sym)
    end

    def fixtures_pattern # :nodoc:
      File.join(base_path, 'fixtures','*.yml')
    end

    def base_path # :nodoc:
      File.join('.','spec')
    end
  end
  
  # The module that will mixin methods based on the fixture files in your 'spec/fixtures'
  # 
  # Example:
  #   describe "something" do
  #     it "should test something" do
  #       users(:jane_smith).first_name.should eql("jane")
  #     end
  #   end
  # 
  #  where there is a spec/fixtures/users.yml file containing a entry of:
  # jane_smith:
  #   first_name: jane
  #   last_name: smith
  module Fixtures
    def Fixtures.included(other_module) # :nodoc:
      fixture = Fixture.new
      fixture.load_all
      fixture.fixture_names.each do |fixture_name|
        self.class_eval do
          define_method(fixture_name) do |entity_key|
            fixture.get_fixture_entity(fixture_name,entity_key.to_s)
          end
        end
      end
    end
  end

end