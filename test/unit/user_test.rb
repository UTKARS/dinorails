require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_fixtures_validity
    User.all.each do |user|
      assert user.valid?, user.errors.full_messages.to_s
    end
  end

  def test_creation
    assert_difference 'User.count' do
      User.create(:name => 'Test Name')
    end
  end
  
  def test_validation
    user = User.new
    assert user.invalid?
    assert_errors_on user, :name
  end
  
  def test_destroy
    assert_difference 'User.count', -1 do
      users(:default).destroy
    end
  end

  def test_self_fancy_name
    name = 'This is my awesome name'
    assert_equal "Dinosaur Owner #{name}", User.fancy_name(name)
  end
  
  def test_fancy_name
    user = users(:default)
    assert_equal "Dinosaur Owner #{user.name}", user.fancy_name
  end
  
end
