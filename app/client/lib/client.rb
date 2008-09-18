class Client
  cattr_accessor :connection_type

  attr_accessor :connection

  def initialize
    self.connection = new_client_to_server_connection
  end

  private

    def new_client_to_server_connection
      Client::Connection.using Client.connection_type
    end
end
