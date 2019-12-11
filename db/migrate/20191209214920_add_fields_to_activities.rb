class AddFieldsToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :due_date, :datetime
    add_column :activities, :title, :string
    add_column :activities, :remind, :boolean, default: false
  end
end
