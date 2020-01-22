class AddStatusToEnterpise < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :current_status, :integer, default: 0
  end
end
