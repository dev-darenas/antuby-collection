class AddContactIdToActivities < ActiveRecord::Migration[6.0]
  def change
    add_reference :activities, :contact, foreign_key: true
    add_column :activities, :remember, :datetime
  end
end
