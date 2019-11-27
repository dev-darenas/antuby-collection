class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.string :sku
      t.boolean :is_master, default: false
      t.references :product, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
