# == Schema Information
#
# Table name: disbursements
#
#  id             :bigint           not null, primary key
#  merchant_id    :bigint
#  week           :integer
#  year           :integer
#  total_orders   :integer          default(0)
#  total_amount   :float(24)        default(0.0)
#  total_disburse :float(24)        default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class DisbursementTest < ActiveSupport::TestCase
  test "should have merchant_id, week, year, total_orders, total_amount and total_disburse" do
    disbursement = Disbursement.new
    assert_not disbursement.save
  end

  test "should have positive total_orders and total_amount" do
    disbursement = Disbursement.new(merchant_id: 1, week: 1, year: 2021, total_orders: -10)
    assert_not disbursement.save
  end

  test "total_disburse should be less or equal than total_amount" do
    disbursement = Disbursement.all.sample
    assert disbursement.total_disburse <= disbursement.total_amount
  end

  test "merchant should have unique disbursement per week and year" do
    disbursement = Disbursement.new(merchant_id: 1, week: 1, year: 2021)
    disbursement2 = Disbursement.new(merchant_id: 1, week: 1, year: 2021)
    assert disbursement.save
    assert_not disbursement2.save
  end
end
