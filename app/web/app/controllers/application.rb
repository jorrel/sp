class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery

  filter_parameter_logging :password

  include AuthenticatedSystem

  before_filter :login_required

  layout 'layout'

  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid

  protected
    def superadmin
      yield if superadmin?
    end
    helper_method :superadmin

    def superadmin?
      !! (logged_in? and current_admin.superadmin?)
    end
    helper_method :superadmin?

    def record_invalid(exception)
      case params[:action]
      when 'create'
        flash.now[:warning] = 'This record cannot be saved because of invalid values'
        render :action => :new
      when 'update'
        flash.now[:warning] = 'The record cannot be updated because of invalid values'
        render :action => :edit
      else
        raise exception
      end
    end

    def require_superadmin
      if not superadmin?
        flash[:warning] = 'The area you were trying to access required superadmin previledges'
        redirect_to '/'
      end
    end
end
