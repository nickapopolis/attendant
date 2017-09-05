require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should create session" do
    post '/users/sign_in', params: {
      user: {
        email: 'one@test.com',
        password: '123456'
      }
    }, as: :json
    body = JSON.parse(@response.body)
    assert body['authentication_token']
  end

end
