require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_creation
    assert_difference 'User.count' do
      User.create(:name => 'Test Name')
    end
  end
  
end
