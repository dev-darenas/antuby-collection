class Payment < ApplicationRecord
  include Notable

  belongs_to :invoice
  validate :balance_amount
  validates :amount, numericality: {greater_than: 0}

  delegate :code, :third_name, :total, :balance, :collector_advisor_name, to: :invoice, prefix: true

  after_save :set_balance
  after_find :set_balance
  after_create :new_payment_promises
  before_save :rollback_amount

  private

  def balance_amount
    if self.amount > self.invoice.balance
      errors.add(:base, 'El pago no puede ser mayor que la deuda')
    end
  end

  def new_payment_promises
    self.invoice.payment_promises.create(
        third_id: self.invoice.third_id,
        enterprise_id: self.invoice.enterprise_id,
        collection_advisor_id: self.invoice.collector_advisor_id, # TODO: maybe this should the how reported the payment
        status: :pending,
        type_activity: :task,
        date_activity: self.next_payment,
        due_date: self.next_payment,
        title: 'Promesa de Pago (Auto generada)',
        remind: true
    )
  end

  def set_balance
    self.invoice.update(
        balance: self.invoice.total - self.invoice.payments.sum(:amount),
        payment_date: self.next_payment
    )
  end

  def rollback_amount
    self.invoice.update(balance: self.invoice.balance + changed_attributes[:amount]) if amount_changed? && changed_attributes[:amount]
  end
end
