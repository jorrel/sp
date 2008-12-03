require File.dirname(__FILE__) + '/../test_helper'
require 'alerts_controller'

class AlertsControllerTest < ActionController::TestCase

  def setup
    login_as :aaron
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_new
    get :new
    assert_response :success
    assert_template 'new'
  end

  def test_create
    alert = Alert.fake
    assert_difference 'Alert.count' do
      post :create, :alert => alert.attributes
      assert_response :redirect
      assert_equal current_admin, Alert.recent.admin
    end
  end

  def test_create_validation_failure
    alert = Alert.fake
    assert_no_difference 'Alert.count' do
      post :create, :alert => {}
      assert_response :success
      assert_template 'new'
    end
  end

  def test_edit
    alert = Alert.fake!
    get :edit, :id => alert.id
    assert_response :success
    assert_template 'edit'
  end

  def test_update
    alert = Alert.fake!
    new_message = alert.message + "Updated!"
    assert_no_difference 'Alert.count' do
      put :update, :id => alert.id, :alert => {:message => new_message}
      assert_response :redirect
      assert_equal new_message, alert.reload.message
    end
  end

  def test_update_validation_failure
    alert = Alert.fake!
    assert_no_difference 'Alert.count' do
      put :update, :id => alert.id, :alert => {:message => ''}
      assert_response :success
      assert_template 'edit'
    end
  end

  def test_delete
    alert = Alert.fake!
    get :delete, :id => alert.id
    assert_response :success
    assert_template 'delete'
  end

  def test_destroy
    alert = Alert.fake!
    assert_difference 'Alert.count', -1 do
      delete :destroy, :id => alert.id
      assert_response :redirect
    end
  end

  def test_update_form
    xhr :post, :update_form, :target_type => 'Personnel'
    assert_response :success
    assert_template 'update_form'
    assert_select_rjs :replace, 'target_form'
  end

  def test_by_admin
    get :by_admin, :login => 'aaron'
    assert_response :success
    assert_template 'by_admin'
  end

end
