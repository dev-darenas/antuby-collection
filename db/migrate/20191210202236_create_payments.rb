class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :invoice, null: false, foreign_key: true
      t.datetime :payment_date
      t.date :next_payment
      t.float :amount
      t.integer :reported_by_id

      t.timestamps
    end
  end
end
