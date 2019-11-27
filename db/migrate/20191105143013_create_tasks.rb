class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.references :third, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.references :enterprise, null: false, foreign_key: true
      t.integer :collection_advisor_id, null: false
      t.integer :collector_id
      t.string :type
      t.text :description
      t.integer :status
      t.date :date_activity
      t.integer :type_activity
      t.integer :call_outcome

      t.timestamps
    end
  end
end
