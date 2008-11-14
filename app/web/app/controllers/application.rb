class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery

  filter_parameter_logging :password

  include AuthenticatedSystem

  before_filter :login_required

  layout 'layout'

  rescue_from ActiveRecord::RecordNotFound, :with => :page_not_found

  protected
    def superadmin
      yield if superadmin?
    end
    helper_method :superadmin

    def superadmin?
      !! (logged_in? and current_admin.superadmin?)
    end
    helper_method :superadmin?

    def page_not_found
      render :text => File.read(File.join(RAILS_ROOT, 'public', '404.html'))
    end

    def require_superadmin
      if not superadmin?
        flash[:warning] = 'The area you were trying to access required superadmin previledges'
        redirect_to '/'
      end
    end
end
