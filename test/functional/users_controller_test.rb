require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def test_get_index
    get :index
    assert assigns(:users)
    assert_response :success
    assert_template :index
  end

  def test_get_show
    user = users(:default)
    get :show, :id => user
    assert assigns(:user)
    assert_response :success
    assert_template :show
  end
  
  def test_get_show_failure
    get :show, :id => 'invalid'
    assert_response :not_found
    assert_template :not_found
  end
  
  def test_get_new
    get :new
    assert assigns(:user)
    assert_response :success
    assert_template :new
  end  

  def test_get_edit
    user = users(:default)
    get :edit, :id => user
    assert assigns(:user)
    assert_response :success
    assert_template :edit
  end

  def test_get_edit_failure
    get :edit, :id => 'invalid'
    assert_response :not_found
    assert_template :not_found
  end

end
