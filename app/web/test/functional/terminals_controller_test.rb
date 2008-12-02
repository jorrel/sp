require File.dirname(__FILE__) + '/../test_helper'
require 'terminals_controller'

class TerminalsControllerTest < ActionController::TestCase

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
    assert_response :success
    assert_template 'index'
  end

  def test_new
    as_superadmin
    get :new
    assert_response :success
    assert_template 'new'
  end

  def test_new_as_non_super
    get :new
    assert_response :redirect
  end

  def test_create
    as_superadmin
    terminal = Terminal.fake
    assert_difference 'Terminal.count' do
      post :create, :terminal => terminal.attributes
      assert_response :redirect
    end
  end

  def test_create_validation_failure
    as_superadmin
    assert_no_difference 'Terminal.count' do
      post :create, :terminal => {}
      assert_response :success
      assert_template 'new'
    end
  end

  def test_create_as_non_super
    terminal = Terminal.fake
    assert_no_difference 'Terminal.count' do
      post :create, :terminal => terminal.attributes
      assert_response :redirect
    end
  end

  def test_edit
    as_superadmin
    get :edit, :id => Terminal.fake!.id
    assert_response :success
    assert_template 'edit'
  end

  def test_edit_as_non_super
    get :edit, :id => Terminal.fake!.id
    assert_response :redirect
  end

  def test_update
    as_superadmin
    terminal = Terminal.fake!
    new_name = terminal.name + '-updtd'
    assert_no_difference 'Terminal.count' do
      put :update, :id => terminal.id, :terminal => {:name => new_name}
      assert_response :redirect
      assert_equal new_name, terminal.reload.name
    end
  end

  def test_update_validation_failure
    as_superadmin
    terminal = Terminal.fake!
    orig_name = terminal.name
    assert_no_difference 'Terminal.count' do
      put :update, :id => terminal.id, :terminal => {:name => ''}
      assert_response :success
      assert_template 'edit'
      assert_equal orig_name, terminal.reload.name
    end
  end

  def test_update_as_non_super
    terminal = Terminal.fake!
    orig_name = terminal.name
    assert_no_difference 'Terminal.count' do
      put :update, :id => terminal.id, :terminal => {:name => ''}
      assert_response :redirect
      assert_equal orig_name, terminal.reload.name
    end
  end

  def test_delete
    as_superadmin
    get :delete, :id => Terminal.fake!.id
    assert_response :success
    assert_template 'delete'
  end

  def test_delete_as_non_super
    get :delete, :id => Terminal.fake!.id
    assert_response :redirect
  end

  def test_destroy
    as_superadmin
    terminal = Terminal.fake!
    assert_difference 'Terminal.count', -1 do
      delete :destroy, :id => terminal.id
      assert_response :redirect
    end
  end

  def test_destroy_as_non_super
    terminal = Terminal.fake!
    assert_no_difference 'Terminal.count' do
      delete :destroy, :id => terminal.id
      assert_response :redirect
    end
  end

end
