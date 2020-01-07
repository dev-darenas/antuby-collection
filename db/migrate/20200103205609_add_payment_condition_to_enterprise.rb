class AddPaymentConditionToEnterprise < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :payment_conditions, :text
  end
end
