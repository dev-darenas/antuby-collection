class AddregistrationActivatedToEnterprises < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :registration_activated, :boolean, default: false
  end
end
