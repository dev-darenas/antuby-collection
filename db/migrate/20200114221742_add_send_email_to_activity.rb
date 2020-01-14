class AddSendEmailToActivity < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :send_now, :boolean
  end
end
