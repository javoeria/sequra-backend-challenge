class CreateDisbursements < ActiveRecord::Migration[6.1]
  def change
    create_table :disbursements do |t|
      t.references :merchant
      t.integer :week
      t.integer :year
      t.integer :total_orders, default: 0
      t.float :total_amount, default: 0.0
      t.float :total_disburse, default: 0.0

      t.timestamps
    end
  end
end
