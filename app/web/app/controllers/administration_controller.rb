class AdministrationController < ApplicationController
  before_filter :require_superadmin

  def index
    @admins = Admin.last :limit => 5
    @terminals = Terminal.last :limit => 5
  end

  private

    def require_superadmin
      if not superadmin?
        flash[:warning] = 'The area you were trying to access required superadmin previledges'
        redirect_to '/'
      end
    end
end
