class AddCollectorToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :collector_advisor_id, :integer
  end
end
