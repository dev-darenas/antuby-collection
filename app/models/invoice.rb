class Invoice < ApplicationRecord
  belongs_to :enterprise
  belongs_to :third
  accepts_nested_attributes_for :third

  delegate :name, :email, :cellphone, :phone, :address_description, to: :third, prefix: true

  has_many :activities
  has_many :visits,
    class_name: 'Activities::Visit'
  has_many :payments

  before_save :set_default_fields, if: :new_record?

  private

  def set_default_fields
    self.balance      = self.total
    self.payment_date = self.expiration_date
  end
end
