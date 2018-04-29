require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
   user =  User.new(password: '123456')  
   assert_not user.save
  end
  test "should not save user without password" do
    user =  User.new(email: 'test@test.com')  
    assert_not user.save
  end
  test "should save user with valid email and password" do
    user =  User.new(email: 'test@test.com', password: '123456')  
    assert user.save
  end
end
