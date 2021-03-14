# == Schema Information
#
# Table name: shoppers
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  email      :string(255)
#  nif        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ShopperTest < ActiveSupport::TestCase
  test "should have name, email and nif" do
    shopper = Shopper.new
    assert_not shopper.save
  end

  test "should have valid email" do
    shopper = Shopper.new(name: 'qwerty', email: 'qwerty', nif: '411111111A')
    assert_not shopper.save
  end

  test "should have valid nif" do
    shopper = Shopper.new(name: 'qwerty', email: 'qwerty@hotmail.com', nif: '123')
    assert_not shopper.save
  end

  test "should have unique nif" do
    shopper = Shopper.new(name: 'qwerty', email: 'qwerty@hotmail.com', nif: '411111111A')
    shopper2 = Shopper.new(name: 'qwerty', email: 'qwerty@hotmail.com', nif: '411111111A')
    assert shopper.save
    assert_not shopper2.save
  end
end
