class AddCreatedByToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :created_by_id, :integer
  end
end
