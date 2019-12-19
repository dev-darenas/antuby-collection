class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.text :description
      t.references :notable, polymorphic: true, null: false
      t.references :user

      t.timestamps
    end
  end
end
