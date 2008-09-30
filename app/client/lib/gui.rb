#
# = Abstract GUI class
#   A GUI class should be a subclass of Client::GUI
#   or include Client::GUIModule
#
class Client

  #
  # Main functionality placed in a module to be easily included
  #
  module GUIModule
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def using(client)
        new_gui_based_on client
      end

      def new_gui_based_on(client)
        type = client.config.gui_type
        "client/#{type}_gui".classify.constantize.new(client)
      rescue LoadError, NameError
        raise ArgumentError,"No client GUI of type: #{type}"
      end
    end

    CONFIG_PATH = File.join(ConfigRoot, 'gui.yml')

    attr_accessor :client
    attr_accessor :config


    #
    # Launch the application
    #
    def start
      raise 'abstract method'
    end

    #
    # Execute a piece of code that may take a long time
    #
    def loading(&block)
      instance_variable_set('@loading', true)
      loading_on
      yield
    ensure
      loading_off
      remove_instance_variable('@loading')
    end

    def loading?
      !!@loading
    end

    def loading_on
    end

    def loading_off
    end
  end


  #
  # The Base GUI class
  #
  class GUI
    include GUIModule

    def initialize(client)
      self.client = client
      self.config = Configuration.new(CONFIG_PATH)
    end
  end

end
