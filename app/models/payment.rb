class Payment < ApplicationRecord
  belongs_to :invoice
  validate :balance_amount
  validates :amount, numericality: { greater_than: 0 }

  after_save :set_balance
  before_save :rollback_amount

  private

  def balance_amount
    if self.amount > self.invoice.balance
      errors.add(:base, 'El pago no puede ser mayor que la deuda')
    end
  end

  def set_balance
    self.invoice.update(
      balance: self.invoice.balance - self.amount,
      payment_date: self.next_payment
    )
  end

  def rollback_amount
    self.invoice.update(balance: self.invoice.balance + changed_attributes[:amount]) if amount_changed? && changed_attributes[:amount]
  end
end
