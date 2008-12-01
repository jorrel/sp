class DashboardController < ApplicationController
  def index
    @alerts = current_admin.alerts.recent 5
    @admins = Admin.recent 5
    @terminals = Terminal.recent 5

    last_modified = [@alerts.first, @admins.first, @terminals.first].compact.map(&:updated_at).compact.sort.last
    fresh_when :etag => [current_admin, :dashboard], :last_modified => last_modified.utc
  end
end
