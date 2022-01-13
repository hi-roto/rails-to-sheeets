require 'test_helper'

class SheetsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sheets_create_url
    assert_response :success
  end

end
