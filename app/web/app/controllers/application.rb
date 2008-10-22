class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery

  filter_parameter_logging :password

  include AuthenticatedSystem

  before_filter :login_required

  layout 'layout'
end
