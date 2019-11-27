class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :enterprise
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end
  end
end
