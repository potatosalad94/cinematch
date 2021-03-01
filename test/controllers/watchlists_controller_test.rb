require "test_helper"

class WatchlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get watchlists_create_url
    assert_response :success
  end
end
