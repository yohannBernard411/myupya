require 'test_helper'

class CoachsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get coachs_show_url
    assert_response :success
  end

end
