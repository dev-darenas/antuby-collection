class AddNumberIdentificationToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :thirds, :identification, :string
  end
end
