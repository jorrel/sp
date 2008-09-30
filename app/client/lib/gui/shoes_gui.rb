#
# = Client GUI using _why's Shoes
#
class Client
  class ShoesGUI < GUI
    #
    # launch the Shoes GUI
    #
    def start
      $config = config    # Use globals so that I have access to

      Shoes.app($config.app = {:width => 300, :height => 400}) {
        flow($config.flow1 = {:width => '100%', :margin => 10}) {
          stack($config.stack1 = {:width => '100%'}) {
            subtitle 'BITS'
            flow($config.stack2 = {:width => '100%'}) {
              inscription 'ID #: '
              self.id_field = edit_line(:width => 200) { editline_changed }
            }
          }
        }
        $config.save
        focus_on_edit_line
      }
    end
  end
  ShoesGui = ShoesGUI   # alias
end

#
# The GUI work-end
#
class Client
  module ShoesGUIModule
    include GUIModule

    attr_accessor :id_field

    #
    # Called after keypress of editline
    #
    def editline_changed

    end

    # TODO: get this to work
    def focus_on_edit_line
      id_field.show
      id_field.focus.inspect
    end
  end
end

class Shoes::App
  include Client::ShoesGUIModule
end
