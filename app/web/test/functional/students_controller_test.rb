require File.dirname(__FILE__) + '/../test_helper'
require 'students_controller'

class StudentsControllerTest < ActionController::TestCase

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
    assert_blocked_from_superadmin_page
  end

  def test_create
    as_superadmin
    student = Student.fake
    assert_difference 'Student.count' do
      post :create, :student => student.attributes
      assert_response :redirect
    end
  end

  def test_create_validation_failure
    as_superadmin
    assert_no_difference 'Student.count' do
      post :create, :student => {}
      assert_response :success
      assert_template 'new'
    end
  end

  def test_create_as_non_super
    student = Student.fake
    assert_no_difference 'Student.count' do
      post :create, :student => student.attributes
      assert_blocked_from_superadmin_page
    end
  end

  def test_show
    as_superadmin
    get :show, :id => (student = Student.fake!).student_id
    assert_response :redirect
    assert_redirected_to :action => :edit, :id => student.student_id
  end

  def test_show_as_non_super
    get :show, :id => Student.fake!.student_id
    assert_response :redirect
    assert_redirected_to :action => :index
  end

  def test_edit
    as_superadmin
    get :edit, :id => Student.fake!.student_id
    assert_response :success
    assert_template 'edit'
  end

  def test_edit_invalid_student_id
    as_superadmin
    student = Student.fake
    assert_nil Student.find_by_student_id(student.student_id)
    get :edit, :id => student.student_id
    assert_response :redirect
  end

  def test_edit_as_non_super
    get :edit, :id => Student.fake!.student_id
    assert_blocked_from_superadmin_page
  end

  def test_update
    as_superadmin
    student = Student.fake!
    new_first_name = student.first_name + ' Updated'
    assert_no_difference 'Student.count' do
      put :update, :id => student.student_id, :student => {:first_name => new_first_name}
      assert_response :redirect
      assert_equal new_first_name, student.reload.first_name
    end
  end

  def test_update_validation_failure
    as_superadmin
    student = Student.fake!
    orig_first_name = student.first_name
    assert_no_difference 'Student.count' do
      put :update, :id => student.student_id, :student => {:first_name => ''}
      assert_response :success
      assert_template 'edit'
      assert_equal orig_first_name, student.reload.first_name
    end
  end

  def test_update_as_non_super
    student = Student.fake!
    orig_first_name = student.first_name
    assert_no_difference 'Student.count' do
      put :update, :id => student.student_id, :student => {:first_name => 'asdasdasdasd'}
      assert_blocked_from_superadmin_page
      assert_equal orig_first_name, student.reload.first_name
    end
  end

  def test_delete
    as_superadmin
    get :delete, :id => Student.fake!.student_id
    assert_response :success
  end

  def test_delete_as_non_super
    get :delete, :id => Student.fake!.student_id
    assert_blocked_from_superadmin_page
  end

  def test_destroy
    as_superadmin
    student = Student.fake!
    assert_difference 'Student.count', -1 do
      delete :destroy, :id => student.student_id
      assert_response :redirect
    end
  end

  def test_destroy_as_non_super
    student = Student.fake!
    assert_no_difference 'Student.count' do
      delete :destroy, :id => student.student_id
      assert_blocked_from_superadmin_page
    end
  end

end
