class CreateOptionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :option_types do |t|
      t.string :name
      t.references :enterprise

      t.timestamps
    end
  end
end
