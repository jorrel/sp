require File.dirname(__FILE__) + '/../test_helper'
require 'admins_controller'

# Re-raise errors caught by the controller.
class AdminsController; def rescue_action_without_handler(e) raise e end; end

class AdminsControllerTest < ActionController::TestCase

  ValidParameters = {
    :login => 'new_admin',
    :password => 'new_password',
    :password_confirmation => 'new_password',
    :superadmin => 0
  }

  def setup
    login_as :aaron
  end

  def test_index
    as_superuser
    get :index
    assert_template 'index'
    assert_response :success
  end

  def test_index_as_non_super
    get :index
    assert_template 'index'
    assert_response :success
  end

  def test_new
    as_superuser
    get :new
    assert_response :success
  end

  def test_new_as_non_super
    get :new
    assert_response :redirect
  end

  def test_create
    as_superuser
    assert_difference 'Admin.count' do
      post :create, :admin => ValidParameters
      assert_response :redirect
    end
  end

  def test_create_validation_failure
    as_superuser
    assert_no_difference 'Admin.count' do
      post :create, :admin => ValidParameters.merge(:login => 'a')
      assert_response :success
      assert_template 'new'
    end
  end

  def test_create_as_non_super
    assert_no_difference 'Admin.count' do
      post :create, :admin => ValidParameters
      assert_response :redirect
    end
  end

  def test_edit
    as_superuser
    get :edit, :id => Admin.fake!.id
    assert_response :success
  end

  def test_edit_as_non_super
    get :edit, :id => Admin.fake!.id
    assert_response :redirect
  end

  def test_update
    as_superuser
    admin = Admin.fake!
    assert_no_difference 'Admin.count' do
      new_login = admin.login + '2'
      put :update, :id => admin.id, :admin => {:login => new_login}
      assert_equal new_login, admin.reload.login
    end
  end

  def test_update_validation_failure
    as_superuser
    admin = Admin.fake!
    assert_no_difference 'Admin.count' do
      too_short_login = 'a'
      put :update, :id => admin.id, :admin => {:login => too_short_login}
      assert_response :success
      assert_template 'edit'
    end
  end

  def test_update_as_non_super
    admin = Admin.fake!
    assert_no_difference 'Admin.count' do
      put :update, :id => admin.id, :admin => {:login => 'new_login'}
      assert_response :redirect
    end
  end

  def test_delete
    as_superuser
    admin = Admin.fake!
    get :delete, :id => admin.id
    assert_response :success
  end

  def test_destroy
    as_superuser
    admin = Admin.fake!
    assert_difference 'Admin.count', -1 do
      delete :destroy, :id => admin.id
      assert_response :redirect
    end
  end

end
