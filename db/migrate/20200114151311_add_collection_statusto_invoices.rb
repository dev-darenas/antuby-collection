class AddCollectionStatustoInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :collection_status, :integer, default: 0
  end
end
