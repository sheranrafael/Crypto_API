require 'test_helper'

class Api::V1::CryptosControllerTest < ActionDispatch::IntegrationTest
  test "should get price" do
    get api_v1_price_url('bitcoin'), params: { currency: 'brl' }
    assert_response :success
  end
end

test "should get price" do
  get api_v1_price_url('bitcoin')
  assert_response :success
end