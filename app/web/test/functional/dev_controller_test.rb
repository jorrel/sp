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
end
