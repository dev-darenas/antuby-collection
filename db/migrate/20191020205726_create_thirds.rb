class CreateThirds < ActiveRecord::Migration[6.0]
  def change
    create_table :thirds do |t|
      t.string :type
      t.string :name
      t.string :email
      t.string :cellphone
      t.string :phone
      t.references :enterprise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
