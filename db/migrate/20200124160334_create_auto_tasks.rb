class CreateAutoTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :auto_tasks do |t|
      t.integer :time
      t.integer :number_days
      t.integer :type_task
      t.string :title
      t.text :description
      t.integer :type_activity
      t.references :enterprise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
