#
# client connection using druby
#

require 'drb'

class Client
  class DrubyConnection < Connection
    def initialize
      load_config
    end

    private

      def load_config
      end
  end
end
