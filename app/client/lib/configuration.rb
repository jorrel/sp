require 'yaml'
require 'erb'
require 'ostruct'

#
# = Configuration Manager
#
class Configuration < OpenStruct
  # filename of the config file
  attr_accessor :file

  delegate :merge!, :reverse_update, :reverse_merge!, :to => '@table'

  def initialize(file)
    self.file = file.respond_to?(:path) ? file.path : file
    load_configuration
  end

  #
  # save the changes to the config to the yml file
  #
  def save
    dump = recursively_stringify_keys_of(marshal_dump).to_yaml
    File.open(file, 'w') { |config_file| config_file.write dump }
  end

  alias :delete :delete_field

  private

    def load_configuration
      marshal_load recursively_symbolize_keys_of( YAML.load( ERB.new( IO.read(file) ).result ) || {})
    end

    def recursively_symbolize_keys_of(hash)
      hash.inject({}) { |h, (k, v)|
        h[k.to_sym] = v.is_a?(Hash) ? recursively_symbolize_keys_of(v) : v
        h
      }
    end

    def recursively_stringify_keys_of(hash)
      hash.inject({}) { |h, (k, v)|
        h[k.to_s] = v.is_a?(Hash) ? recursively_stringify_keys_of(v) : v
        h
      }
    end
end

