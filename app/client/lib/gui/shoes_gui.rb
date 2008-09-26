#
# = Client GUI using _why's Shoes
#
class Client
  class ShoesGUI < GUI
    #
    # launch the Shoes GUI
    #
    def launch
      $config = config
      Shoes.app($config.app = {:width => 300, :height => 400}) {
        flow($config.flow1 = {:width => '100%', :margin => 10}) {
          stack($config.stack1 = {:width => '100%'}) {
            subtitle 'BITS'
          }
        }
        $config.save
      }
    end
  end
  ShoesGui = ShoesGUI   # alias
end
