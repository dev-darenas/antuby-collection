class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :description
      t.references :addressable, polymorphic: true
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
