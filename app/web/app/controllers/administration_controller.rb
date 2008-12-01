class AdministrationController < ApplicationController
  before_filter :require_superadmin

  def index
    @admins = Admin.recent 5
    @terminals = Terminal.recent 5
  end

  protected

    def self.non_superadmin_action(*actions)
      skip_before_filter :require_superadmin, :only => actions
    end
end
