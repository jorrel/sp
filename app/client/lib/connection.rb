#
# Client connection
#

class Client
  class Connection
    DefaultConnectionType = :druby

    def self.using(connection_type = nil)
      connection_type ||= DefaultConnectionType
      new_connection_based_on connection_type
    end

    def connect
      raise 'abstract method'
    end

    private

      def self.new_connection_based_on(type)
        begin
          "client/#{type}_connection".classify.constantize.new
        rescue LoadError, NameError
          raise ArgumentError,"No client connection of type: #{type}"
        end
      end
  end
end
