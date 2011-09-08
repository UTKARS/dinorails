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
    assert_response :redirect
    assert_redirected_to :action => :index
    assert flash[:error]
  end
  

end
