class DashboardController < ApplicationController
  def index
    @alerts = current_admin.alerts.recent 5
    @admins = Admin.recent 5
    @terminals = Terminal.recent 5
  end
end
