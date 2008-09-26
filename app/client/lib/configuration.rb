require 'yaml'
require 'erb'

class Configuration
  attr_accessor :file
  def initialize(file)
    self.file = file.path if file.respond_to?(:path)
  end
end

class Hash
  def recursively_symbolize_keys
    inject({}) { |h, (k, v)| h[k.to_sym] = v.is_a?(Hash) ? v.recursively_symbolize_keys : v; h }
  end
end

