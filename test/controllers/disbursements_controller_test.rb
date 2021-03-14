require "test_helper"

class DisbursementsControllerTest < ActionController::TestCase
  def setup
    @controller = Api::V1::DisbursementsController.new
  end

  test "return the disbursements for a given merchant on a given week" do
    get(:index, params: { week: 1, year: 2018, merchant_id: 1 })
    disbursement = JSON.parse(@response.body)['data'].sample
    assert_response 200
    assert_equal(1, disbursement['merchant_id'])
    assert_equal(1, disbursement['week'])
    assert_equal(2018, disbursement['year'])
    assert_instance_of(Integer, disbursement['total_orders'])
    assert_instance_of(Float, disbursement['total_amount'])
    assert_instance_of(Float, disbursement['total_disburse'])
  end

  test "return all of them if no merchant is provided" do
    get(:index, params: { week: 1, year: 2018 })
    disbursement = JSON.parse(@response.body)['data'].sample
    assert_response 200
    assert_instance_of(Integer, disbursement['merchant_id'])
    assert_equal(1, disbursement['week'])
    assert_equal(2018, disbursement['year'])
    assert_instance_of(Integer, disbursement['total_orders'])
    assert_instance_of(Float, disbursement['total_amount'])
    assert_instance_of(Float, disbursement['total_disburse'])
  end

  test "should have week and year params" do
    assert_raises(Apipie::ParamMissing) do
      get(:index, params: {})
    end
  end

  test "should have valid week and year" do
    assert_raises(Apipie::ParamInvalid) do
      get(:index, params: { week: 'a', year: 2018 })
    end
  end
end
