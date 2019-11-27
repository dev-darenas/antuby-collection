class OptionType < ApplicationRecord

  # Relation
  has_one :enterprise
  has_many :product_option_types, dependent: :destroy, inverse_of: :option_type
  has_many :products, through: :product_option_types

  has_many :option_values
  accepts_nested_attributes_for :option_values,
    reject_if: lambda {
      |a| a[:name].blank?
    }, allow_destroy: true

  # Validations
  validates :name, presence: true
end
