#
# = Client GUI using _why's Shoes
#
class Client
  class ShoesGUI < GUI
    #
    # launch the Shoes GUI
    #
    def start
      $gui_config = config    # Use globals so that I have access to

      Shoes.app($gui_config.app = {:width => 500, :height => 400}) {
        flow($gui_config.flow1 = {:width => '100%', :margin => 10}) {
          stack($gui_config.stack1 = {:width => '100%'}) {
            subtitle 'BITS'
            flow($gui_config.stack2 = {:width => '100%'}) {
              inscription 'ID #: '
              self.id_field = edit_line(:width => 200) { editline_changed }
            }
          }
        }
        $gui_config.save
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

    def id_value
      id_field.text
    end

    #
    # Called after keypress of editline
    #
    def editline_changed
        puts "called"
#         puts (id_field.methods.sort - Object.methods).inspect
      if valid_id?
        perform_query
      elsif illegal_id?
        alert('Illegal ID')
      else
      end
    end

    def update_page(info)
      id_field.text = info['id_value'] || ''
      focus_on_edit_line
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
