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

  def test_creation
    assert_difference 'User.count' do
      post :create, :user => { :name => 'Fred Flintstone' }
      assert_response :redirect
      assert_redirected_to :action => :show, :id => User.last
      assert flash[:notice]
    end
  end

  def test_creation_failure
    assert_no_difference 'User.count' do
      post :create, :user => { }
      assert_response :success
      assert_template :new
      assert flash[:error]
    end
  end

  def test_update
    user = users(:default)
    put :update, :id => user, :user => {
      :name => 'Updated User Name'
    }
    assert_response :redirect
    assert_redirected_to :action => :show, :id => user
    assert flash[:notice]
    user.reload
    assert_equal 'Updated User Name', user.name
  end
  
  def test_update_failure
    user = users(:default)
    put :update, :id => user, :user => {
      :name => nil
    }
    assert_response :success
    assert_template :edit
    assert flash[:error]
    user.reload
    assert_not_nil user.name
  end

  def test_destroy
    user = users(:default)
    assert_difference 'User.count', -1 do
      delete :destroy, :id => user
      assert_response :redirect
      assert_redirected_to :action => :index
      assert flash[:notice]
    end
  end
    
end
