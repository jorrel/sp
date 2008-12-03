#
# DevController
#
# Used for development purposes only
#
class DevController < ApplicationController

  before_filter :require_superadmin, :only => :super_only_action

  def demo_flash
    flash.now[params[:level]] = params[:message]
    render :action => 'index'
  end

  def super_only_action
    render :nothing => true
  end
end
