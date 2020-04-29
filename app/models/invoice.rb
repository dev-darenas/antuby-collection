class Invoice < ApplicationRecord
  include Notable

  enum collection_status: %w(pending paymen_promise dispute bad completed)
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
             foreign_key: :collector_advisor_id,
             optional: true

  has_one :sale,
    foreign_key: :invoice_id,
    class_name: 'Invoices::Sale'

  delegate :name, to: :collector_advisor, prefix: true, allow_nil: true

  before_save :set_default_fields, if: :new_record?
  before_save :check_status, unless: :new_record?
  before_save :update_payment_date

  scope :active, -> {
    where('collection_status IS NOT ?', :completed)
  }

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

  def check_status
    self.completed! if balance_changed? && !self.completed?
  end

  def update_payment_date
    self.payment_date = self.expiration_date
  end
end
