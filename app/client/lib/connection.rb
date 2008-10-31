#
# Client connection
#
class Client
  class Connection
    Status = {:success => 200, :error => 500, :failed => 400}

    def self.using(connection_type)
      new_connection_based_on connection_type
    end

    def connect
      raise 'abstract method'
    end

    private

      def self.new_connection_based_on(type)
        "client/#{type}_connection".classify.constantize.new
      rescue LoadError, NameError
        raise ArgumentError,"No client connection of type: #{type}"
      end
  end
end
