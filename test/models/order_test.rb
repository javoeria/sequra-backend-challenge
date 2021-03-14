# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  merchant_id  :bigint
#  shopper_id   :bigint
#  amount       :float(24)        default(0.0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  completed_at :datetime
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "should have merchant_id, shopper_id and amount" do
    order = Order.new
    assert_not order.save
  end

  test "should have positive amount" do
    order = Order.new(merchant_id: 1, shopper_id: 1, amount: -10)
    assert_not order.save
  end

  test "amount should be readonly" do
    order = Order.new(merchant_id: 1, shopper_id: 1, amount: 10)
    assert order.save
    order.amount = 20
    assert order.save
    order.reload
    assert_equal(10, order.amount)
  end

  test "disburse should be less or equal than amount" do
    order = Order.completed.sample
    assert order.disburse <= order.amount
  end

  test "completed order should have datetime" do
    order = Order.completed.sample
    assert order.completed_at != nil
  end

  test "1% fee for amounts smaller than 50€" do
    order = orders(:one)
    assert_equal(0.001, order.fee)
  end

  test "0.95% fee for amounts between 50€ - 300€" do
    order = orders(:two)
    assert_equal(0.0095, order.fee)
  end

  test "0.85% fee for amounts over 300€" do
    order = orders(:three)
    assert_equal(0.0085, order.fee)
  end
end
