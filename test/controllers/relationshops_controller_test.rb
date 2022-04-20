require "test_helper"

class RelationshopsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get relationshops_followings_url
    assert_response :success
  end

  test "should get followers" do
    get relationshops_followers_url
    assert_response :success
  end
end
