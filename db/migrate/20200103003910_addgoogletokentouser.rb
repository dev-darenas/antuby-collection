class Addgoogletokentouser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :google_refresh_token, :text
    add_column :users, :google_token, :text
  end
end
