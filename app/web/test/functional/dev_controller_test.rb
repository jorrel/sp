require File.dirname(__FILE__) + '/../test_helper'
require 'dev_controller'

class DevControllerTest < ActionController::TestCase

  def setup
    login_as :aaron
  end

  def test_demo_flash
    get :demo_flash, :level => 'notice', :message => 'This is a test message'
    assert_response :success
    assert_template 'index'
    assert_select 'div.flash.notice span', 'This is a test message'
  end

  def test_super_only_action
    as_superadmin
    get :super_only_action
    assert_response :success
  end

  def test_super_only_action_as_non_super
    get :super_only_action
    assert_response :redirect
    assert_blocked_from_superadmin_page
  end

  def test_super_only_action_as_non_super_xhr
    xhr :get, :super_only_action
    assert_blocked_from_superadmin_page
  end

end
