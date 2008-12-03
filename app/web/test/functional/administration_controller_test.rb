require File.dirname(__FILE__) + '/../test_helper'
require 'administration_controller'

class AdministrationControllerTest < ActionController::TestCase

  def setup
    login_as :aaron
  end

  def test_index
    as_superadmin
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_index_as_non_super
    get :index
    assert_blocked_from_superadmin_page
  end

end
