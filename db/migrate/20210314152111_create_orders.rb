class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :merchant
      t.references :shopper
      t.float :amount, default: 0.0

      t.timestamps
      t.datetime :completed_at, precision: 6
    end
  end
end
