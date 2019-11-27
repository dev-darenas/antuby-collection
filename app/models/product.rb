class Product < ApplicationRecord
  
  # Relation
  has_one :enterprise
  has_many :product_option_types, dependent: :destroy, inverse_of: :product
  has_many :option_types, through: :product_option_types
  accepts_nested_attributes_for :product_option_types,
    reject_if: lambda {
      |a| a[:option_type_id].blank?
    }, allow_destroy: true
  
  after_validation :set_slug, only: [:create, :update]
  
  has_one :master,
          -> { where is_master: true },
          inverse_of: :product,
          class_name: 'Variant',
          autosave: true

  has_many :variants,
            -> { where is_master: false },
            inverse_of: :product,
            class_name: 'Variant'

  # Validations
  validates :name, :sku, presence: true

  delegate :sku, :sku=, to: :find_or_build_master
  delegate :price, :price=, to: :find_or_build_master

  def to_param
    "#{id}-#{slug}"
  end

  def find_or_build_master
    master || build_master
  end

  private

  def set_slug
    self.slug = name.to_s.parameterize
  end
end
