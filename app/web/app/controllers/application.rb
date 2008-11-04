class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery

  filter_parameter_logging :password

  include AuthenticatedSystem

  before_filter :login_required

  layout 'layout'

  protected
    def superadmin
      yield if superadmin?
    end
    helper_method :superadmin

    def superadmin?
      !! (logged_in? and current_admin.superadmin?)
    end
    helper_method :superadmin?
end
