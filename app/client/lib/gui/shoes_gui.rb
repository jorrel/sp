#
# = Client GUI using _why's Shoes
#
class Client
  class ShoesGUI < GUI
    #
    # The Default Configuration
    #
    DefaultConfig = {
      :app => {:title => 'BITS Terminal', :width => 320, :height => 400},

      :main_flow=> {:width => '100%', :margin => 10},
      :main_stack => {:width => '100%'},

      :id_field_box => {:width => '100%'},

      :response_box => {:width => '100%'},
      :person_details_box => {:width => '70%', :margin_top => 10},

      :note_box_box => {:width => '100%', :margin_top => 10},

      :id_field => {:width => 200},
      :note_box => {:width => 300, :height => 200}
    }


    #
    # launch the Shoes GUI
    #
    def start
      patch_shoes_app_for_gui!
      $gui_config = config    # Use globals so that I have access to

      puts "env: #{$environment}"
      dev {
        event('setting config to defaults') {
          $gui_config.load_configuration DefaultConfig
        }
      }

      Shoes.app($gui_config.app) {
        flow($gui_config.main_flow) {
          stack($gui_config.main_stack) {
            caption 'Barcode Identification Terminal'

            flow($gui_config.id_field_box) {
              inscription 'ID #: '
              self.id_field = edit_line($gui_config.id_field) { editline_changed }
              self.load_indicator = inscription('')
            }

            flow($gui_config.response_box) {
              stack($gui_config.person_details_box) {
                flow{
                  inscription('Name:')
                  self.person_name = inscription ''
                }
              }
              image 'gui/shoes/action_check.png', :width => 60, :height => 60
#               image 'gui/shoes/action_delete.png', :width => 60, :height => 60
            }

            flow($gui_config.note_box_box) {
              inscription('Bulletin Messages:')
              self.note_box = edit_box($gui_config.note_box)
              self.note_box.text = 'Invalid ID'
            }
          }
        }
        self.name = 'test'
        puts (self.methods.sort - Object.methods).inspect
        focus_on_edit_line  # TODO: not working
      }

      dev { event('saving gui config') { $gui_config.save } }
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

    attr_accessor :id_field, :load_indicator, :note_box, :person_name

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
        alert('Invalid ID')
      else
      end
    end

    def update_page(info)
      id_field.text = info['id_value'] || ''
      person_name.text = info['name'] || ''
      unless info['messages'].blank?
        note_box.text = info['messages'].join("\n\n")
      end
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
