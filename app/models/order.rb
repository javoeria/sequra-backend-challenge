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
class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  attr_readonly :amount

  scope :completed, -> { where.not(completed_at: nil) }

  def self.from_week(week, year)
    where('WEEK(completed_at) = ? AND YEAR(completed_at) = ?', week, year)
  end

  def disburse
    amount * (1 - fee)
  end

  def fee
    if amount < 50
      0.001
    elsif amount.between?(50, 300)
      0.0095
    else
      0.0085
    end
  end
end
