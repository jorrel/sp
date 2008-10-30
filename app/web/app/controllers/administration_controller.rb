class AdministrationController < ApplicationController
  before_filter :require_superadmin

  def index
    @admins = Admin.recent 5
    @terminals = Terminal.recent 5
  end

  private

    def require_superadmin
      if not superadmin?
        flash[:warning] = 'The area you were trying to access required superadmin previledges'
        redirect_to '/'
      end
    end
end
