class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :full_name
      t.string :phone
      t.string :cellphone
      t.string :email
      t.references :third, null: false, foreign_key: true

      t.timestamps
    end
  end
end
