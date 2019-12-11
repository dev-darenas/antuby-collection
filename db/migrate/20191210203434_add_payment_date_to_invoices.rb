class AddPaymentDateToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :payment_date, :date
  end
end
