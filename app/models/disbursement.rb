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
class Disbursement < ApplicationRecord
  belongs_to :merchant

  validates :week, :year, :total_orders, :total_amount, :total_disburse, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :merchant_id, uniqueness: { scope: [:week, :year] }
end
