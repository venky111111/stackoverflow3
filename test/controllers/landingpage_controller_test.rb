require "test_helper"

class LandingpageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get landingpage_index_url
    assert_response :success
  end

  test "should get show" do
    get landingpage_show_url
    assert_response :success
  end
end
