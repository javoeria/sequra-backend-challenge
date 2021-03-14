# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p 'destroy_all'
Disbursement.destroy_all
Order.destroy_all
Shopper.destroy_all
Merchant.destroy_all

p 'merchants'
merchants = JSON.parse(File.read('db/dataset/merchants.json'))
merchants['RECORDS'].each { |record| Merchant.create(record) }

p 'shoppers'
shoppers = JSON.parse(File.read('db/dataset/shoppers.json'))
shoppers['RECORDS'].each { |record| Shopper.create(record) }

p 'orders'
orders = JSON.parse(File.read('db/dataset/orders.json'))
orders['RECORDS'].each { |record| Order.create(record) }

p 'disbursements'
merchants = Merchant.all
(0..13).to_a.each do |week|
  merchants.each do |merchant|
    orders = merchant.orders.completed.from_week(week, 2018)
    Disbursement.create(
      merchant_id: merchant.id,
      week: week,
      year: 2018,
      total_orders: orders.size,
      total_amount: orders.pluck(:amount).sum.round(2),
      total_disburse: orders.map(&:disburse).sum.round(2)
    )
  end
end
