class Enterprise < ApplicationRecord
  # relations
  has_many :users
  has_many :products
  has_many :option_types
  has_many :clients
  has_many :providers
  has_many :admin_invoices
  has_many :invoices
  has_many :activities, through: :invoices
  has_many :sales, class_name: 'Invoices::Sale'
  has_many :auto_tasks
  has_many :payments, through: :invoices

  mount_uploader :excel, ExcelUploader

  enum current_status: %w(active pay_pending is_delete)
end
