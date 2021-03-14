class DisbursementService
  def self.get(week:, year:, merchant_id: nil)
    if merchant_id.blank?
      Disbursement.where(week: week, year: year)
    else
      Disbursement.where(week: week, year: year, merchant_id: merchant_id)
    end
  end

  def self.create_all(week:, year:)
    Merchant.all.each do |merchant|
      orders = merchant.orders.completed.from_week(week, year)
      Disbursement.create(
        merchant_id: merchant.id,
        week: week,
        year: year,
        total_orders: orders.size,
        total_amount: orders.pluck(:amount).sum.round(2),
        total_disburse: orders.map(&:disburse).sum.round(2)
      )
    end
  end
end
