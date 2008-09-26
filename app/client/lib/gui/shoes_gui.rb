#
# = Client GUI using _why's Shoes
#
class Client
  class ShoesGUI < GUI
    #
    # launch the Shoes GUI
    #
    def launch
      Shoes.app(config.app) {
      }
    end
  end
  ShoesGui = ShoesGUI   # alias
end
