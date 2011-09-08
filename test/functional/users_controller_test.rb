require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def test_get_index
    get :index
    assert assigns(:users)
    assert_response :success
    assert_template :index
  end

end
