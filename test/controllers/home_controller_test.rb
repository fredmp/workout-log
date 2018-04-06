require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get dashboard" do
    sign_in users(:user)
    get home_dashboard_url
    assert_response :success
  end
end
