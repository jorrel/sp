#
# Main Client class/namespace
#
class Client
  CONFIG_PATH = File.join(ConfigRoot, 'client.yml')

  attr_accessor :connection
  attr_accessor :config

  def initialize
    setup_config
    self.connection = new_client_to_server_connection
  end

  private

    def setup_config
      self.config = Configuration.new(CONFIG_PATH)
      if config.environment == 'dev'
        event 'dev environment detected'
        $environment = :dev
      end
    end

    def new_client_to_server_connection
      Client::Connection.using config.connection_type
    end
end
