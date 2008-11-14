class AdministrationController < ApplicationController
  before_filter :require_superadmin

  def index
    @admins = Admin.recent 5
    @terminals = Terminal.recent 5
  end
end
