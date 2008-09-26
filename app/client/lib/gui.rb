#
# = Abstract GUI class
#
class Client
  class GUI
    CONFIG_PATH = File.join(ConfigRoot, 'gui.yml')

    attr_accessor :client
    attr_accessor :config

    def self.using(client)
      new_gui_based_on client
    end

    def initialize(client)
      self.client = client
      self.config = Configuration.new(CONFIG_PATH)
    end

    #
    # Launch the application
    #
    def launch
      raise 'abstract method'
    end

    private

      def self.new_gui_based_on(client)
        type = client.config.gui_type
        "client/#{type}_gui".classify.constantize.new(client)
      rescue LoadError, NameError
        raise ArgumentError,"No client GUI of type: #{type}"
      end
  end
end
