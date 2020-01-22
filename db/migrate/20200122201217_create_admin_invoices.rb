class CreateAdminInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_invoices do |t|
      t.float :total
      t.text :description
      t.references :enterprise, null: false, foreign_key: true
      t.integer :status, default: 0
      t.date :payment_date

      t.timestamps
    end
  end
end
