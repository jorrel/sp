class Client
  class ShoesGUI < GUI
    def launch
      Shoes.app(:width => 700, :height => 500) {
        button('push') {
        }
      }
    end
  end
end
