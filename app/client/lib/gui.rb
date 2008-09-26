#
# = Abstract GUI class
#
class Client
  class GUI
    attr_accessor :client
    attr_accessor :config

    def self.using(client, gui_type = nil)
      Client::ShoesGUI.new(client)
    end

    def initialize(client)
      self.client = client
      self.config = Configuration.new('config/gui.yml')
    end

    #
    # Launch the application
    #
    def launch
      raise 'abstract method'
    end
  end
end
