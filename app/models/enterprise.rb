class Enterprise < ApplicationRecord
  # relations
  has_many :users
  has_many :products
  has_many :option_types
  has_many :clients
  has_many :providers

  has_many :invoices
  has_many :sales, class_name: 'Invoices::Sale'
end
