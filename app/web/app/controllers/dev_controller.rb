#
# DevController
#
# Used for development purposes only
#
class DevController < ApplicationController
  def demo_flash
    flash.now[params[:level]] = params[:message]
    render :action => 'index'
  end
end
