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

  def initialize(argument = {})
    if argument.is_a?(String) or argument.respond_to?(:path)
      self.file = path_from argument
      hash = configuration_from_file
    elsif argument.is_a?(Hash)
      hash = argument
    else
      raise ArgumentError, "invalid parameter: #{argument.inspect}"
    end
    load_configuration hash
  end

  #
  # save the changes back to the config file
  #
  def save
    raise "Cannot save, use #{self.class.name}#save_to and provide a filename" if file.nil?
    save_to file
  end

  #
  # save changes to a file
  #
  def save_to(file)
    path = file.respond_to?(:path) ? file.path : file
    self.file = path if self.file.nil? # further calls to 'save' will save to same file
    dump = recursively_stringify_keys_of(marshal_dump).to_yaml
    File.open(file, 'w') { |config_file| config_file.write dump }
  end

  alias :delete :delete_field

  #
  # given a hash, load that hash as the configuration
  #
  def load_configuration(hash)
    marshal_load prepare_configuration(hash)
  end

  private

    def prepare_configuration(hash)
      recursively_symbolize_keys_of(hash)
    end

    def configuration_from_file
      YAML.load( ERB.new( IO.read(file) ).result ) || {}
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

    def path_from(file)
      if file.is_a?(String)
        file
      elsif file.respond_to?(:path)
        file.path
      else
        raise ArgumentError, "Invalid file or file path: #{file}"
      end
    end
end

