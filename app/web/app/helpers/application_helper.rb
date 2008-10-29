# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def superadmin
    yield if superadmin?
  end

  def superadmin?
    logged_in? and current_admin.superadmin?
  end
end
