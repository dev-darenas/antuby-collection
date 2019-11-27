class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :code, null: false
      t.string :type, null: false
      t.references :enterprise, null: false, foreign_key: true
      t.references :third, null: false, foreign_key: true
      t.date :creation_date
      t.date :expiration_date
      t.float :subtotal, default: 0
      t.float :total, default: 0
      t.float :balance, default: 0
      t.text :description

      t.timestamps
    end
  end
end
