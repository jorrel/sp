require File.dirname(__FILE__) + '/../test_helper'
require 'administration_controller'

class AdministrationControllerTest < ActionController::TestCase
  def test_index
    as_superadmin
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_index_as_non_super
    get :index
    assert_response :redirect
  end
end
