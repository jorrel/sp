class Client
  class GUI
    attr_accessor :client

    def self.using(client, gui_type = nil)
      Client::ShoesGUI.new(client)
    end

    def initialize(client)
      self.client = client
    end

    #
    # Launch the application
    #
    def launch
      raise 'abstract method'
    end
  end
end
