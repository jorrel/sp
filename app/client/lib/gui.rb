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

    attr_accessor :client
    attr_accessor :config

    CONFIG_PATH = File.join(ConfigRoot, 'gui.yml')
    def config
      @config ||= Configuration.new(CONFIG_PATH)
    end

    #
    # Launch the application
    #
    def start
      raise 'abstract method'
    end

    #
    # The current content of the ID text field
    #
    def id_value
      raise 'abstract method'
    end

    #
    # Updates the page with the fetched info
    #
    def update_page(info)
      raise 'abstract method'
    end

    #
    # Start fetching info about the student/personel
    #
    def perform_query
      loading do
        info = fetch_info(id_value)
        update_page info
      end
    end

    #
    # Fetch data from server through connection
    #
    def fetch_info(id_num)
      {'id_value' => id_num}  #TODO
    end

    #
    # Check if the id_value is valid
    #
    def valid_id?
      !! (id_value =~ /^\d{9}$/ or id_value =~ /^\d{4}-\d{5}$/)
    end

    #
    # Checks if the id_value is possibly unfinished
    #
    def unfinished_id?
      !! (id_value.sub('-','') =~ /^\d*$/)
    end

    #
    # Checks if the id_value is illegal
    def illegal_id?
      !(valid_id? or unfinished_id?)
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
    end
  end

end
