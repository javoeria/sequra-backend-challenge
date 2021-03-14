# == Schema Information
#
# Table name: merchants
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  email      :string(255)
#  cif        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class MerchantTest < ActiveSupport::TestCase
  test "should have name, email and cif" do
    merchant = Merchant.new
    assert_not merchant.save
  end

  test "should have valid email" do
    merchant = Merchant.new(name: 'qwerty', email: 'qwerty', cif: 'A611111111')
    assert_not merchant.save
  end

  test "should have valid cif" do
    merchant = Merchant.new(name: 'qwerty', email: 'qwerty@hotmail.com', cif: '123')
    assert_not merchant.save
  end

  test "should have unique cif" do
    merchant = Merchant.new(name: 'qwerty', email: 'qwerty@hotmail.com', cif: 'A611111111')
    merchant2 = Merchant.new(name: 'qwerty', email: 'qwerty@hotmail.com', cif: 'A611111111')
    assert merchant.save
    assert_not merchant2.save
  end
end
