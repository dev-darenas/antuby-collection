class Invoice < ApplicationRecord
  belongs_to :enterprise
  belongs_to :third
  accepts_nested_attributes_for :third

  delegate :name, :email, :cellphone, :phone, :address_description, to: :third, prefix: true

  has_many :activities
  has_many :visits,
    class_name: 'Activities::Visit'
  has_many :payments
  belongs_to :collector_advisor,
             class_name: 'User',
             foreign_key: :collector_advisor_id

  delegate :name, to: :collector_advisor, prefix: true, allow_nil: true

  before_save :set_default_fields, if: :new_record?

  scope :expired, -> { 
    where('expiration_date <= ?',Date.today.beginning_of_day)
  }
  scope :not_expired, -> {
    where('expiration_date >= ?',Date.today.beginning_of_day)
  }

  scope :collector, -> (collector_id) {
    where(collector_advisor_id: collector_id)
  }

  private

  def set_default_fields
    self.balance      = self.total
    self.payment_date = self.expiration_date
  end
end
