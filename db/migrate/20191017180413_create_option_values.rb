class CreateOptionValues < ActiveRecord::Migration[6.0]
  def change
    create_table :option_values do |t|
      t.references :option_type
      t.string :name

      t.timestamps
    end
  end
end
