#
# = Client GUI using _why's Shoes
#
class Client
  class ShoesGUI < GUI
    #
    # launch the Shoes GUI
    #
    def start
      patch_shoes_app_for_gui!
      $gui_config = config    # Use globals so that I have access to

      Shoes.app($gui_config.app = {:width => 500, :height => 400}) {
        flow($gui_config.flow1 = {:width => '100%', :margin => 10}) {
          stack($gui_config.stack1 = {:width => '100%'}) {
            subtitle 'BITS'
            flow($gui_config.stack2 = {:width => '100%'}) {
              inscription 'ID #: '
              self.id_field = edit_line(:width => 200) { editline_changed }
              self.load_indicator = inscription('')
            }
          }
        }
        $gui_config.save
        focus_on_edit_line  # TODO: not working
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

    attr_accessor :id_field, :load_indicator

    def id_value
      id_field.text
    end

    #
    # Called after keypress of editline
    #
    def editline_changed
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
      id_field.focus
    end

    def loading_on
      load_indicator.text = "loading ..."
    end

    def loading_off
      load_indicator.text = ''
      focus_on_edit_line
    end
  end
end


#
# Insert Client::ShoesGUIModule functionality into Shoes::App
#
def patch_shoes_app_for_gui!
  unless $shoes_app_patched
    Shoes::App.send(:include, Client::ShoesGUIModule)
    $shoes_app_patched = true
  end
end
