require 'test_helper'

class HelloControllerTest < ActionController::TestCase
  test "should get helloworld" do
    get :helloworld
    assert_response :success
  end

end
