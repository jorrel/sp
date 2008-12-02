require File.dirname(__FILE__) + '/../test_helper'
require 'dashboard_controller'

class DashboardControllerTest < ActionController::TestCase

  def test_index
    as_superadmin
    get :index
    assert_response :success
  end

  def test_index_as_non_super
    login_as :aaron
    get :index
    assert_response :success
  end

end
