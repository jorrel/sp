#
# Main Client class/namespace
#
class Client
  CONFIG_PATH = File.join(ConfigRoot, 'client.yml')

  attr_accessor :connection
  attr_accessor :config

  def initialize
    self.config = Configuration.new(CONFIG_PATH)
    self.connection = new_client_to_server_connection
  end

  private

    def new_client_to_server_connection
      Client::Connection.using config.connection_type
    end
end
