class AddExcelToEnterprise < ActiveRecord::Migration[6.0]
  def change
    add_column :enterprises, :excel, :string
  end
end
