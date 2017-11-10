require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get sites_top_url
    assert_response :success
  end

end
